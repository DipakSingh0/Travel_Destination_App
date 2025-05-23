import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_anim/features/core/model/destination_model.dart';
import '../services/map_service.dart';

class MapController {
  final MapService _mapService = MapService();
  late GoogleMapController _mapController;
  final double _defaultZoom = 15.0;

  LatLng? currentLocation;
  bool isLoading = true;
  Set<Marker> markers = {};
  bool canAddMarkers = false;
  BitmapDescriptor customMarkerIcon = BitmapDescriptor.defaultMarker;
  MapType mapType = MapType.normal;

  Future<void> initializeMap({
    required Destination? destination,
    required List<LatLng>? additionalMarkers,
    required bool showCurrentLocation,
    required bool enableAddMarkers,
  }) async {
    try {
      if (showCurrentLocation) {
        currentLocation = await _mapService.getCurrentLocation();
      }

      LatLng? initialLocation;
      if (destination != null) {
        initialLocation = destination.location;
      }

      markers = _mapService.createMarkers(
        initialLocation: initialLocation,
        additionalMarkers: additionalMarkers,
        currentLocation: currentLocation,
        markerIcon: customMarkerIcon,
      );

      isLoading = false;
    } catch (e) {
      isLoading = false;
      throw Exception('Map initialization failed: $e');
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> goToCurrentLocation() async {
    if (currentLocation != null) {
      await _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation!, _defaultZoom),
      );
    }
  }

  void toggleMapType() {
    mapType = mapType == MapType.normal ? MapType.hybrid : MapType.normal;
  }

  void toggleMarkerMode() {
    canAddMarkers = !canAddMarkers;
  }

  void addMarker(LatLng position, String title) {
    markers.add(
      Marker(
        markerId: MarkerId('marker_${position.latitude}_${position.longitude}'),
        position: position,
        icon: customMarkerIcon,
        infoWindow: InfoWindow(title: title),
      ),
    );
  }
} 