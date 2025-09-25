import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../shared/widgets/appbar_leading_icon.dart';
import '../../../shared/widgets/heightbox.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/text_widget.dart';
import '../../../core/constants/app_color.dart';
import '../controller/location_details_controller.dart';
import '../controller/my_location_controller.dart';
import '../model/nearby_location_model.dart';
import 'tiles/location_details_tile.dart';
import 'widgets/draggable_bottom_sheet.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({super.key});

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  late NearbyLocationModel nearbyLocationModel;
  late MyLocationController myLocationController;
  late LocationDetailsController controller;

  @override
  void initState() {
    super.initState();
    myLocationController = Get.find();
    controller = Get.find();
    nearbyLocationModel = Get.arguments?[ArgumentsKey.nearbyLocationModel];

    // Get Service location points
    WidgetsBinding.instance.addPostFrameCallback(
        (value) => controller.getServicePoints(locationType: nearbyLocationModel.locationType.value));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            leading: const AppBarLeadingIcon(),
            centerTitle: false,
            title: ButtonText(
              text: nearbyLocationModel.title,
              textColor: AppColors.lightAppBarIconColor,
            ),
            titleSpacing: 0.0,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                // Map view
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: myLocationController.currentLocation != null
                        ? LatLng(myLocationController.currentLocation!.latitude!,
                            myLocationController.currentLocation!.longitude!)
                        : myLocationController.defaultLatLng,
                    zoom: 12,
                  ),
                  markers: {
                    // Current marker
                    if (myLocationController.currentPositionMarker != null) myLocationController.currentPositionMarker!,
                    // Destination markers
                    ...controller.destinationMarkers
                  },
                  mapType: MapType.normal,
                ),

                // BottomSheet
                DraggableBottomSheet(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_gas_station,
                          color: AppColors.lightTextColor,
                          size: 18,
                        ),
                        Expanded(
                          child: BodyText(
                            text: ' ${controller.servicePoints.length} locations found',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 10),
                    controller.isLoading.value
                        ? const CenterLoadingWidget()
                        : ListView.separated(
                            padding: const EdgeInsets.only(bottom: 12),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.servicePoints.length,
                            separatorBuilder: (context, index) => const HeightBox(height: 10),
                            itemBuilder: (context, index) =>
                                LocationDetailsTile(model: controller.servicePoints[index]),
                          )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
