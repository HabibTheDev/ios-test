import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/services/local/awake_lock_service.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/car_direction_controller.dart';
import '../widgets/start_stop_button.dart';

class CarDirection extends StatefulWidget {
  const CarDirection({super.key});

  @override
  State<CarDirection> createState() => _CarDirectionState();
}

class _CarDirectionState extends State<CarDirection> {
  @override
  void initState() {
    super.initState();
    final CarDirectionController carCtrl = Get.find();
    final latitude = Get.arguments?[ArgumentsKey.latitude];
    final longitude = Get.arguments?[ArgumentsKey.longitude];
    final destinationAddress = Get.arguments?[ArgumentsKey.destinationAddress];

    debugPrint('latitude:$latitude');
    debugPrint('longitude:$longitude');
    debugPrint('destinationAddress:$destinationAddress');

    // Init controller data
    WidgetsBinding.instance.addPostFrameCallback((value) {
      carCtrl.initData(latitude: latitude, longitude: longitude, destAddress: destinationAddress);
    });
    AwakeLockService.enableAwakeLock();
  }

  @override
  void dispose() {
    AwakeLockService.disableAwakeLock();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return GetBuilder<CarDirectionController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.lightCardColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            leading: const Icon(Icons.location_on_rounded, size: 20),
            title: ButtonText(text: '${locale?.car} ${locale?.location}'),
            titleSpacing: 0.0,
            actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))],
          ),
          body: _bodyUI(controller),
          bottomNavigationBar: SafeArea(child: _bottomNavUI(controller, locale)),
        );
      },
    );
  }

  Widget _bodyUI(CarDirectionController controller) => Stack(
    alignment: Alignment.center,
    children: [
      // Map view
      GoogleMap(
        trafficEnabled: true,
        compassEnabled: true,
        buildingsEnabled: true,
        initialCameraPosition: CameraPosition(
          target: controller.currentLocation != null
              ? LatLng(controller.currentLocation!.latitude!, controller.currentLocation!.longitude!)
              : controller.defaultLatLng,
          zoom: 12,
        ),
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            points: controller.polylineCoordinates,
            color: Colors.blue,
            width: 5,
            jointType: JointType.round,
            startCap: Cap.roundCap,
          ),
        },
        markers: {
          // Current marker
          if (controller.currentPositionMarker != null) controller.currentPositionMarker!,

          // Destination marker
          Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(
              controller.destinationLocation?.latitude ?? 0.0,
              controller.destinationLocation?.longitude ?? 0.0,
            ),
            icon: controller.destinationCarMarkerIcon,
            infoWindow: InfoWindow(title: controller.destinationAddress),
          ),
        },
        mapType: MapType.normal,
        onMapCreated: controller.onMapCreated,
      ),

      // Start / Stop button
      Positioned(
        left: 8,
        bottom: 4,
        child: StartStopButton(
          startTracking: controller.startJourney,
          onTap: () {
            if (controller.startJourney) {
              controller.stopTracking();
            } else {
              controller.startTracking();
            }
          },
        ),
      ),

      // Loading widget
      if (controller.isLoading) const CenterLoadingWidget(),
    ],
  );

  Widget _bottomNavUI(CarDirectionController controller, AppLocalizations? locale) => Container(
    height: 168,
    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
    color: AppColors.lightCardColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.grey.shade300,
              child: const CircleAvatar(radius: 5, backgroundColor: AppColors.errorColor),
            ).paddingOnly(right: 10),
            BodyText(text: '${locale?.yourLocation}', maxLine: 1),
          ],
        ),
        CustomPaint(size: const Size(1, 16), painter: DashedLineVerticalPainter()).paddingOnly(left: 9),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_rounded, color: AppColors.errorColor, size: 18).paddingOnly(right: 10),
            Expanded(child: BodyText(text: controller.destinationAddress, maxLine: 2)),
          ],
        ).paddingOnly(bottom: 12),

        // Distance & Duration
        Row(
          children: [
            Expanded(
              child: BorderCardTile(
                hideBorder: true,
                bgColor: AppColors.lightBgColor,
                leading: const Icon(Icons.pin_drop, color: AppColors.primaryColor, size: 20),
                title: '${controller.travelDistance} km',
                subTitle: '${locale?.distance}',
              ),
            ),
            const WidthBox(width: 10),
            Expanded(
              child: BorderCardTile(
                hideBorder: true,
                bgColor: AppColors.lightBgColor,
                leading: const Icon(Icons.watch_later_rounded, color: AppColors.primaryColor, size: 20),
                title: controller.travelTime,
                subTitle: '${locale?.approximateTime}',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = size.width;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
