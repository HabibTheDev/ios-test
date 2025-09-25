import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/my_location_controller.dart';
import '../model/nearby_location_model.dart';
import 'tiles/nearby_location_tile.dart';
import 'widgets/draggable_bottom_sheet.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyLocationController>(
      init: MyLocationController(),
      builder: (controller) {
        return Stack(
          children: [
            // Map view
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.currentLocation != null
                    ? LatLng(
                        controller.currentLocation!.latitude!,
                        controller.currentLocation!.longitude!,
                      )
                    : controller.defaultLatLng,
                zoom: 12,
              ),
              markers: {
                // Current marker
                if (controller.currentPositionMarker != null) controller.currentPositionMarker!,
              },
              mapType: MapType.normal,
              onMapCreated: controller.onMapCreated,
            ),

            DraggableBottomSheet(
              children: [
                const BodyText(
                  text: 'Nearby locations',
                  fontWeight: FontWeight.w700,
                ).paddingOnly(bottom: 10),
                GridView.builder(
                  padding: const EdgeInsets.only(bottom: 12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2),
                  itemCount: NearbyLocationModel.nearbyLocationList.length,
                  itemBuilder: (context, index) =>
                      NearbyLocationTile(model: NearbyLocationModel.nearbyLocationList[index]),
                )
              ],
            ),
            // Loading widget
            if (controller.isLoading) const CenterLoadingWidget(),
          ],
        );
      },
    );
  }
}
