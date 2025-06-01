import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_ease/common/utils/imports.dart';
import '../services/map_service.dart';


class MapController {
  final MapService _mapService = MapService();
  late GoogleMapController _mapController;
  final double _defaultZoom =20.0;  // ------- default zoom level

  LatLng? currentLocation;
  bool isLoading = true;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  double? distanceInKm;
  // LatLng? midpoint;  
  bool canAddMarkers = false;
  BitmapDescriptor customMarkerIcon = BitmapDescriptor.defaultMarker;
  MapType mapType = MapType.normal; //--- normal/satellite

  Future<void> initializeMap({
    required Destination? destination,
    required List<LatLng>? additionalMarkers,
    required bool showCurrentLocation,
    // required bool enableAddMarkers,
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
      //--- line between current and destination location
      if (currentLocation != null && initialLocation != null) {
        polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            points: [currentLocation!, initialLocation],
            color: Colors.blue,
            width: 4,
          ),
        };
// ------------ for distance calculation
        final distanceInMeters = Geolocator.distanceBetween(
          currentLocation!.latitude,
          currentLocation!.longitude,
          initialLocation.latitude,
          initialLocation.longitude,
        );

        distanceInKm = distanceInMeters / 1000;

      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      throw Exception('Map initialization failed: $e');
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }
  //---- Animate  camera to the our curent location.
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

}
