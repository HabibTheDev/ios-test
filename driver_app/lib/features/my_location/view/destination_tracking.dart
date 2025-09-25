import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../shared/widgets/border_card_tile.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/text_widget.dart';
import '../../../shared/widgets/widthbox.dart';
import '../controller/destination_tracking_controller.dart';
import '../model/service_point_model.dart';
import 'widgets/start_stop_button.dart';

class DestinationTracking extends StatefulWidget {
  const DestinationTracking({super.key});

  @override
  State<DestinationTracking> createState() => _DestinationTrackingState();
}

class _DestinationTrackingState extends State<DestinationTracking> {
  late DestinationTrackingController destinationTrackingController;
  late ServicePointModel servicePointModel;

  @override
  void initState() {
    super.initState();
    destinationTrackingController = Get.find();
    servicePointModel = Get.arguments?[ArgumentsKey.servicePointModel];
    WidgetsBinding.instance
        .addPostFrameCallback((value) => destinationTrackingController.initTracking(servicePointModel));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((value) {
      destinationTrackingController.stopTracking();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DestinationTrackingController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: const Icon(Icons.local_gas_station, size: 20, color: AppColors.lightAppBarIconColor),
          title: ButtonText(text: 'Going to ${servicePointModel.locationName}'),
          titleSpacing: 0.0,
          actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))],
        ),
        body: _bodyUI(controller),
        bottomNavigationBar: SafeArea(child: _bottomNavUI(controller)),
      );
    });
  }

  Widget _bodyUI(DestinationTrackingController controller) => Stack(
        children: [
          // Map view
          GoogleMap(
            trafficEnabled: true,
            buildingsEnabled: true,
            compassEnabled: true,
            onMapCreated: controller.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: controller.currentLocation != null
                  ? LatLng(
                      controller.currentLocation!.latitude!,
                      controller.currentLocation!.longitude!,
                    )
                  : controller.defaultLatLng,
              zoom: 12,
            ),
            polylines: {
              Polyline(
                  polylineId: const PolylineId('route'),
                  points: controller.polylineCoordinates,
                  color: Colors.blue,
                  width: 5)
            },
            markers: {
              // Current marker
              if (controller.currentPositionMarker != null) controller.currentPositionMarker!,
              // Destination marker
              Marker(
                markerId: const MarkerId('destination'),
                position: LatLng(
                    controller.destinationLocation?.latitude ?? 0.0, controller.destinationLocation?.longitude ?? 0.0),
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(title: servicePointModel.locationName, snippet: servicePointModel.address),
              ),
            },
            mapType: MapType.normal,
          ),

          // Start / Stop button
          Positioned(
            left: 10,
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

  Widget _bottomNavUI(DestinationTrackingController controller) => Container(
        height: 244,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
        color: AppColors.lightCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: servicePointModel.locationName ?? 'N/A',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textSize: 16,
            ).paddingOnly(bottom: 4),
            SmallText(
              text: servicePointModel.description ?? 'N/A',
              maxLine: 2,
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(bottom: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 9,
                  backgroundColor: Colors.grey.shade300,
                  child: const CircleAvatar(
                    radius: 5,
                    backgroundColor: AppColors.errorColor,
                  ),
                ).paddingOnly(right: 10),
                const BodyText(
                  text: 'Your location',
                  maxLine: 1,
                )
              ],
            ),
            CustomPaint(size: const Size(1, 16), painter: DashedLineVerticalPainter()).paddingOnly(left: 9),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.errorColor,
                  size: 18,
                ).paddingOnly(right: 10),
                Expanded(
                  child: BodyText(
                    text: servicePointModel.address ?? 'N/A',
                    maxLine: 2,
                  ),
                )
              ],
            ).paddingOnly(bottom: 12),

            // Distance & Duration
            Row(
              children: [
                Expanded(
                  child: BorderCardTile(
                    hideBorder: true,
                    bgColor: AppColors.lightBgColor,
                    leading: const Icon(
                      Icons.pin_drop,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    title: '${controller.travelDistance} km',
                    subTitle: 'Distance',
                  ),
                ),
                const WidthBox(width: 10),
                Expanded(
                  child: BorderCardTile(
                    hideBorder: true,
                    bgColor: AppColors.lightBgColor,
                    leading: const Icon(
                      Icons.watch_later_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    title: controller.travelTime,
                    subTitle: 'Approximate time',
                  ),
                ),
              ],
            )
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
