import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;

import '../../../flavor_config.dart';
import '../../repository/remote/car_direction_repo.dart';
import '../../utils/app_toast.dart';
import '../../utils/utils.dart';

class CarDirectionService implements CarDirectionRepo {
  static final Dio _dio = Dio();

  @override
  Future<List<LatLng>> getPolyLinePoints({required LatLng currentLocation, required LatLng destinationLocation}) async {
    try {
      List<LatLng> polyLinePoints = [];
      String url =
          '${AppFlavor.mapDirectionsUrl}origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${destinationLocation.latitude},${destinationLocation.longitude}&key=${AppFlavor.mapApiKey}';

      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        List<LatLng> polylineCoordinates = [];

        if (data['routes'].isNotEmpty) {
          List<dynamic> steps = data['routes'][0]['legs'][0]['steps'];
          for (var step in steps) {
            List<dynamic> points = decodePolyline(step['polyline']['points']);
            for (var point in points) {
              polylineCoordinates.add(LatLng(point[0], point[1]));
            }
          }
          polyLinePoints = await getSnappedPolyLinePoints(polylineCoordinates);
          return polyLinePoints;
        } else {
          showToast('No route found');
          return [];
        }
      } else {
        debugPrint('Directions API error: ${response.data}', wrapWidth: 1024);
        showToast('Something went wrong');
        return [];
      }
    } catch (e) {
      debugPrint('Route Error: $e');
      showToast('Something went wrong');
      return [];
    }
  }

// Decode polyline to list of LatLng

  List<dynamic> decodePolyline(String encoded) {
    List<dynamic> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      poly.add([(lat / 1E5).toDouble(), (lng / 1E5).toDouble()]);
    }
    return poly;
  }

  Future<List<LatLng>> getSnappedPolyLinePoints(List<LatLng> points) async {
    if (points.isEmpty) return [];

    String path = points.map((p) => '${p.latitude},${p.longitude}').join('|');
    String url = '${AppFlavor.mapSnapToRoadsUrl}path=$path&key=${AppFlavor.mapApiKey}&interpolate=true';

    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        List<LatLng> snappedPoints = [];

        for (var snappedLocation in data['snappedPoints']) {
          snappedPoints.add(
            LatLng(snappedLocation['location']['latitude'], snappedLocation['location']['longitude']),
          );
        }
        return snappedPoints;
      } else {
        debugPrint('Snap to Roads API error: ${response.data}');
      }
    } catch (e) {
      debugPrint('Snapped Route Error: $e');
    }

    return points;
  }

  // Get the address from LatLng using the Google Geocoding API
  @override
  Future<String> getAddressFromLatLng(LatLng latLng) async {
    try {
      final String url =
          '${AppFlavor.mapGeocodeUrl}latlng=${latLng.latitude},${latLng.longitude}&key=${AppFlavor.mapApiKey}';
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'].isNotEmpty) {
          String address = data['results'][0]['formatted_address'];
          return address;
        } else {
          return "Not found";
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      showToast('Error getting destination address');
    }
    return 'Not found';
  }

  // Calculate travel time
  @override
  Future<String> getTravelTime({required LatLng currentLocation, required LatLng destinationLocation}) async {
    try {
      final directionsUrl =
          '${AppFlavor.mapDirectionsUrl}origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${destinationLocation.latitude},${destinationLocation.longitude}&key=${AppFlavor.mapApiKey}';

      final response = await _dio.get(directionsUrl);
      if (response.statusCode == 200) {
        final data = response.data;

        if (data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final leg = route['legs'][0];
          // Returns travel time as text (e.g., "12 mins")
          return leg['duration']['text'];
        } else {
          return 'Not found';
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      showToast('Error getting approximate time');
    }
    return 'Not found';
  }

  // Calculate total distance from polylineCoordinates
  @override
  double getTotalDistance({required List<LatLng> polylineCoordinates}) {
    double totalDistance = 0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _calculateDistance(polylineCoordinates[i], polylineCoordinates[i + 1]);
    }
    if (totalDistance == 0) {
      return 0;
    }
    return roundDouble(totalDistance / 1000);
  }

  // Calculate the distance between two LatLng points in meters
  double _calculateDistance(LatLng start, LatLng end) {
    const p = 0.017453292519943295; // Pi / 180
    final a = 0.5 -
        cos((end.latitude - start.latitude) * p) / 2 +
        cos(start.latitude * p) * cos(end.latitude * p) * (1 - cos((end.longitude - start.longitude) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000; // 2 * R * asin... (in meters)
  }

  @override
  double calculateBearing(LatLng start, LatLng end) {
    double lat1 = start.latitude * (pi / 180.0);
    double lon1 = start.longitude * (pi / 180.0);
    double lat2 = end.latitude * (pi / 180.0);
    double lon2 = end.longitude * (pi / 180.0);
    double dLon = lon2 - lon1;
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double bearing = atan2(y, x);
    return (bearing * (180.0 / pi) + 360.0) % 360.0;
  }
}
