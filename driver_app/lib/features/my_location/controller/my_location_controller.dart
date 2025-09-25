import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../shared/utils/app_toast.dart';
import '../view/widgets/current_marker_widget.dart';

class MyLocationController extends GetxController {
  // variables
  static final Location location = Location();
  bool isLoading = true;
  bool serviceEnabled = false;

  GoogleMapController? mapController;
  LocationData? currentLocation;
  PermissionStatus permissionGranted = PermissionStatus.denied;
  Marker? currentPositionMarker;
  BitmapDescriptor currentMarkerIcon = BitmapDescriptor.defaultMarker;
  LatLng defaultLatLng = const LatLng(23.85179708508075, 90.40806081479167);

  @override
  void onInit() async {
    super.onInit();
    await checkLocationPermission();
    await getLocation();
    await buildCurrentMarker();
    updatePinOnMap();

    isLoading = false;
    update();
  }

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }

  // Create map
  Future<void> onMapCreated(GoogleMapController googleMapController) async {
    mapController = googleMapController;
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

  // Check location permission
  Future<void> checkLocationPermission() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }
  }

  // Get current location
  Future<void> getLocation() async {
    try {
      currentLocation = await location.getLocation();
      debugPrint('Current Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}');
    } catch (e) {
      showToast('Error getting current location');
    }
  }

  // Update current location
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
}
