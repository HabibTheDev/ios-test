import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../shared/repository/remote/my_location_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../model/service_point_model.dart';
import '../view/widgets/current_marker_widget.dart';
import 'my_location_controller.dart';

class DestinationTrackingController extends GetxController {
  final _locationService = ServiceLocator.get<MyLocationRepo>();
  // variables
  bool isLoading = true;
  GoogleMapController? mapController;
  StreamSubscription<LocationData>? locationSubscription;
  static final Location location = Location();
  List<LatLng> polylineCoordinates = [];
  Marker? currentPositionMarker;
  LocationData? currentLocation;
  LatLng? destinationLocation;
  BitmapDescriptor currentMarkerIcon = BitmapDescriptor.defaultMarker;

  double travelDistance = 0.0;
  String travelTime = '';
  bool startJourney = false;
  LatLng defaultLatLng = const LatLng(23.85179708508075, 90.40806081479167);

  // Create map
  Future<void> onMapCreated(GoogleMapController googleMapController) async {
    mapController = googleMapController;
  }

  // Init Data
  Future<void> initTracking(ServicePointModel servicePointModel) async {
    final MyLocationController myLocationController = Get.find();
    polylineCoordinates = servicePointModel.polylineCoordinates ?? [];
    currentLocation = myLocationController.currentLocation;
    destinationLocation =
        LatLng(double.parse(servicePointModel.latitude ?? '0.0'), double.parse(servicePointModel.longitude ?? '0.0'));
    travelDistance = servicePointModel.travelDistanceInKm ?? 0.0;
    travelTime = servicePointModel.travelTime ?? 'Not found';
    await buildCurrentMarker();
    isLoading = false;
    debugPrint('polylineCoordinates: ${polylineCoordinates.length}');
    update();
  }

  Future<void> startTracking() async {
    startLocationOnChangeListening();
  }

  Future<void> stopTracking() async {
    startJourney = false;
    locationSubscription?.cancel();
    update();
  }

  // Create current marker
  Future<void> buildCurrentMarker() async {
    currentMarkerIcon = await const CurrentMarkerWidget().toBitmapDescriptor(
      logicalSize: const Size(80, 80),
      imageSize: const Size(80, 80),
    );
    currentPositionMarker = Marker(
      markerId: const MarkerId('source'),
      position:
          currentLocation != null ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!) : defaultLatLng,
      icon: currentMarkerIcon,
    );
    update();
  }

  Future<void> startLocationOnChangeListening() async {
    LatLng? lastPosition;
    startJourney = true;
    update();

    locationSubscription = location.onLocationChanged.listen((LocationData currentLoc) async {
      LatLng newPosition = LatLng(currentLoc.latitude!, currentLoc.longitude!);
      currentLocation = currentLoc;

      if (lastPosition != null) {
        double bearing = ServiceLocator.get<MyLocationRepo>().calculateBearing(lastPosition!, newPosition);

        updateCurrentMarker();
        updatePinOnMap(bearing);
        getTotalDistance();
        getTravelTime();
        update();
      }
      lastPosition = newPosition;
      debugPrint('Current Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}');
    });
  }

  // Update current marker with current position
  void updateCurrentMarker() {
    currentPositionMarker = Marker(
      markerId: const MarkerId('source'),
      position:
          currentLocation != null ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!) : defaultLatLng,
      icon: currentMarkerIcon,
    );
    update();
  }

  // Update camera position
  void updatePinOnMap([double bearing = 0]) {
    if (mapController != null) {
      debugPrint('Updated Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}');
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocation != null
                ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
                : defaultLatLng,
            zoom: 16,
            bearing: bearing,
          ),
        ),
      );
      update();
    }
  }

  // Total distance
  void getTotalDistance() {
    if (polylineCoordinates.isEmpty) {
      return;
    }
    travelDistance = _locationService.getTotalDistance(polylineCoordinates: polylineCoordinates);
    debugPrint('Travel Distance =  $travelDistance');
    update();
  }

  // Approximate travel time
  Future<void> getTravelTime() async {
    if (currentLocation == null || destinationLocation == null) {
      return;
    }
    travelTime = await _locationService.getTravelTime(
        currentLocation: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        destinationLocation: destinationLocation!);
    debugPrint('Approximate Time = $travelTime');
    update();
  }
}
