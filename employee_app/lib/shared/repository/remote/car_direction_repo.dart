import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CarDirectionRepo {
  Future<List<LatLng>> getPolyLinePoints({
    required LatLng currentLocation,
    required LatLng destinationLocation,
  });
  Future<String> getAddressFromLatLng(LatLng latLng);
  Future<String> getTravelTime({required LatLng currentLocation, required LatLng destinationLocation});
  double getTotalDistance({required List<LatLng> polylineCoordinates});
  double calculateBearing(LatLng start, LatLng end);
}
