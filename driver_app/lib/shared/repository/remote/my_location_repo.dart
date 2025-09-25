import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../features/my_location/model/service_point_model.dart';

abstract class MyLocationRepo {
  Future<List<ServicePointModel>> getServicePoints({
    required LatLng currentLocation,
    required double radiusInKm,
    required String locationType,
  });
  Future<List<ServicePointModel>> getCompanyLocations({required LatLng currentLocation, required double radiusInKm});
  Future<List<LatLng>> getPolyLinePoints({
    required LatLng currentLocation,
    required LatLng destinationLocation,
  });
  Future<String> getAddressFromLatLng(LatLng latLng);
  Future<String> getTravelTime({required LatLng currentLocation, required LatLng destinationLocation});
  double getTotalDistance({required List<LatLng> polylineCoordinates});
  double calculateBearing(LatLng start, LatLng end);
}
