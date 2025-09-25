import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/repository/remote/car_direction_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../view/widgets/current_marker_widget.dart';

class CarDirectionController extends GetxController {
  CarDirectionController({required this.carDirectionRepo});
  final CarDirectionRepo carDirectionRepo;

  // variables
  static final Dio dio = Dio();
  bool isLoading = true;
  bool serviceEnabled = false;

  final Location location = Location();
  GoogleMapController? mapController;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  LatLng? destinationLocation;

  PermissionStatus permissionGranted = PermissionStatus.denied;
  StreamSubscription<LocationData>? locationSubscription;
  Marker? currentPositionMarker;
  BitmapDescriptor destinationCarMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentMarkerIcon = BitmapDescriptor.defaultMarker;

  double travelDistance = 0.0;
  String travelTime = 'Calculating...';
  String destinationAddress = 'Finding...';
  bool startJourney = false;

  LatLng defaultLatLng = const LatLng(23.85179708508075, 90.40806081479167);

  Future<void> initData({required String? latitude, required String? longitude, required String? destAddress}) async {
    final double lat = double.parse(latitude ?? '0.0');
    final double long = double.parse(longitude ?? '0.0');

    destinationAddress = destAddress ?? 'Not found';
    destinationLocation = LatLng(lat, long);
    polylineCoordinates.clear();

    await checkLocationPermission();
    await getLocation();
    await buildDestinationMarker();
    await buildCurrentMarker();
    await getPolyLinePoints();
    updatePinOnMap();
    isLoading = false;
    update();

    getTotalDistance();
    getTravelTime();
  }

  // Create map
  Future<void> onMapCreated(GoogleMapController googleMapController) async {
    mapController = googleMapController;
  }

  // Create destination marker
  Future<void> buildDestinationMarker() async {
    // Destination marker icon
    destinationCarMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(30, 70)),
      Assets.assetsImageCarMarker,
    );
  }

  // Create current marker
  Future<void> buildCurrentMarker() async {
    currentMarkerIcon = await const CurrentMarkerWidget().toBitmapDescriptor(
      logicalSize: const Size(80, 80),
      imageSize: const Size(80, 80),
    );
    currentPositionMarker = Marker(
      markerId: const MarkerId('source'),
      position: currentLocation != null
          ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
          : defaultLatLng,
      icon: currentMarkerIcon,
    );
    update();
  }

  // Update current marker with current position
  void updateCurrentMarker() {
    currentPositionMarker = Marker(
      markerId: const MarkerId('source'),
      position: currentLocation != null
          ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
          : defaultLatLng,
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

  // Draw polylines
  Future<void> getPolyLinePoints() async {
    if (currentLocation == null && destinationLocation == null) {
      return;
    }
    polylineCoordinates = await carDirectionRepo.getPolyLinePoints(
      currentLocation: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      destinationLocation: destinationLocation!,
    );
    update();
  }

  Future<void> startTracking() async {
    if (polylineCoordinates.isEmpty) {
      showToast('Route not found');
      return;
    }
    LatLng? lastPosition;
    startJourney = true;
    update();
    showToast('Live tracking started');
    locationSubscription = location.onLocationChanged.listen((LocationData currentLoc) async {
      LatLng newPosition = LatLng(currentLoc.latitude!, currentLoc.longitude!);
      currentLocation = currentLoc;

      if (lastPosition != null) {
        double bearing = carDirectionRepo.calculateBearing(lastPosition!, newPosition);
        await getPolyLinePoints();
        getTravelTime();
        getTotalDistance();
        updateCurrentMarker();
        updatePinOnMap(bearing);
      }
      lastPosition = newPosition;
      update();
      debugPrint('Current Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}');
      // Stop tracking after reaching to the destination.
      if (travelDistance < 0.02) {
        showAlertDialog(
          'Destination reached!',
          alertIcon: Icons.check_circle,
          description: 'You\'ve made it! You\'re now at $destinationAddress.',
          themeColor: AppColors.primaryColor,
        );
        stopTracking();
      }
    });
  }

  Future<void> stopTracking() async {
    showToast('Live tracking stopped');
    startJourney = false;
    locationSubscription?.cancel();
    update();
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
            zoom: 15,
            bearing: bearing,
          ),
        ),
      );
      update();
    }
  }

  // Approximate travel time
  // Future<void> getDestinationAddress() async {
  //   if (destinationLocation == null) {
  //     return;
  //   }
  //   destinationAddress = await _carDirectionRepo.getAddressFromLatLng(destinationLocation!);
  //   debugPrint('Destination Address =  $destinationAddress');
  //   update();
  // }

  // Total distance from a list of LatLng points
  void getTotalDistance() {
    if (polylineCoordinates.isEmpty) {
      return;
    }
    travelDistance = carDirectionRepo.getTotalDistance(polylineCoordinates: polylineCoordinates);
    debugPrint('Travel Distance =  $travelDistance');
    update();
  }

  // Approximate travel time
  Future<void> getTravelTime() async {
    if (currentLocation == null || destinationLocation == null) {
      return;
    }
    travelTime = await carDirectionRepo.getTravelTime(
      currentLocation: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      destinationLocation: destinationLocation!,
    );
    debugPrint('Approximate Time = $travelTime');
    update();
  }

  @override
  void onClose() {
    locationSubscription?.cancel();
    mapController?.dispose();
    super.onClose();
  }
}
