import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;

import '../../../core/constants/app_string.dart';
import '../../../features/my_location/model/service_point_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../../flavor_config.dart';
import '../../api/api_exception.dart';
import '../../api/api_client.dart';
import '../../repository/remote/my_location_repo.dart';
import '../../utils/app_toast.dart';
import '../../utils/utils.dart';

class MyLocationService extends ApiClient implements MyLocationRepo {
  // Dio instance for API call
  static final Dio _dio = Dio();

  // Get routes between two locations
  @override
  Future<List<LatLng>> getPolyLinePoints({required LatLng currentLocation, required LatLng destinationLocation}) async {
    List<LatLng> polylineCoordinates = [];
    try {
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        googleApiKey: AppFlavor.mapApiKey,
        request: PolylineRequest(
            origin: PointLatLng(currentLocation.latitude, currentLocation.longitude),
            destination: PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
            mode: TravelMode.driving),
      );

      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      return polylineCoordinates;
    } catch (e) {
      debugPrint('Route Error: $e');
      if (e.toString().contains('ZERO_RESULTS')) {
        showToast('No route found');
      } else if (e.toString().contains('REQUEST_DENIED')) {
        showToast('Request denied');
      } else {
        showToast('Something went wrong');
      }
    }
    return [];
  }

  // Get the address from LatLng using the Google Geocoding API
  @override
  Future<String> getAddressFromLatLng(LatLng latLng) async {
    try {
      final String url =
          '${ApiEndpoint.mapGeoodeUrl}latlng=${latLng.latitude},${latLng.longitude}&key=${AppFlavor.mapApiKey}';
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
          '${ApiEndpoint.mapDirectionsUrl}origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${destinationLocation.latitude},${destinationLocation.longitude}&key=${AppFlavor.mapApiKey}';

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

  @override
  Future<List<ServicePointModel>> getServicePoints({
    required LatLng currentLocation,
    required double radiusInKm,
    required String locationType,
  }) async {
    try {
      final response = await getRequest(
        path: ApiEndpoint.nearbyServiceLocation,
        queryParameters: {
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude,
          'radiusInKm': radiusInKm,
          'locationType': locationType
        },
        isTokenRequired: true,
      );
      return servicePointModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return [];
  }

  @override
  Future<List<ServicePointModel>> getCompanyLocations(
      {required LatLng currentLocation, required double radiusInKm}) async {
    try {
      final response = await getRequest(
        path: ApiEndpoint.nearbyCompanyLocation,
        queryParameters: {
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude,
          'radiusInKm': radiusInKm,
        },
        isTokenRequired: true,
      );
      return servicePointModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return [];
  }
}
