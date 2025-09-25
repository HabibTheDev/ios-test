import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/repository/remote/my_location_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/utils/enums.dart';
import '../model/service_point_model.dart';
import 'my_location_controller.dart';

class LocationDetailsController extends GetxController {
  final _locationService = ServiceLocator.get<MyLocationRepo>();

  final RxBool isLoading = true.obs;
  final RxList<ServicePointModel> servicePoints = <ServicePointModel>[].obs;
  final RxList<Marker> destinationMarkers = <Marker>[].obs;

  Future<void> getServicePoints({required String locationType}) async {
    final MyLocationController myLocationController = Get.find();
    if (myLocationController.currentLocation == null) {
      showToast('Current location not found');
      return;
    }

    // Get current location
    final currentLocation =
        LatLng(myLocationController.currentLocation!.latitude!, myLocationController.currentLocation!.longitude!);

    // Get service points / companies
    if (locationType == NearbyLocationType.companyLocation.value) {
      servicePoints.value = await _locationService.getCompanyLocations(
        currentLocation: currentLocation,
        radiusInKm: 10.0,
      );
    } else {
      servicePoints.value = await _locationService.getServicePoints(
        currentLocation: currentLocation,
        radiusInKm: 10.0,
        locationType: locationType,
      );
    }
    // Get polyLineCoordinates, travelDistanceInKm, travelTime
    if (servicePoints.isNotEmpty) {
      await Future.forEach(servicePoints, (item) async {
        final destinationLocation = LatLng(double.parse(item.latitude ?? '0.0'), double.parse(item.longitude ?? '0.0'));
        final polylineCoordinates = await _locationService.getPolyLinePoints(
            currentLocation: currentLocation, destinationLocation: destinationLocation);
        final travelDistanceInKm = _locationService.getTotalDistance(polylineCoordinates: polylineCoordinates);
        final travelTime = await _locationService.getTravelTime(
            currentLocation: currentLocation, destinationLocation: destinationLocation);

        // Update polyLineCoordinates, travelDistanceInKm, travelTime values for each item
        servicePoints[servicePoints.indexOf(item)] = item.copyWith(
            polylineCoordinates: polylineCoordinates, travelDistanceInKm: travelDistanceInKm, travelTime: travelTime);
      });

      // Generate marker of destinations
      destinationMarkers.clear();
      for (var item in servicePoints) {
        destinationMarkers.add(Marker(
          markerId: MarkerId('${item.id}'),
          position: LatLng(double.parse(item.latitude ?? '0.0'), double.parse(item.longitude ?? '0.0')),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: item.locationName, snippet: item.address),
        ));
      }
    }
    isLoading(false);
  }
}
