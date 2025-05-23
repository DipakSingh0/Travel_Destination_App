import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  Future<LatLng?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await Geolocator.openLocationSettings();
        if (!serviceEnabled) return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }

      if (permission == LocationPermission.deniedForever) return null;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      throw Exception('Could not get location: ${e.toString()}');
    }
  }

  Set<Marker> createMarkers({
    required LatLng? initialLocation,
    required List<LatLng>? additionalMarkers,
    required LatLng? currentLocation,
    required BitmapDescriptor markerIcon,
  }) {
    final markers = <Marker>{};

    // ----add current location marker to map---- // 
    if (currentLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: currentLocation,
          icon: markerIcon,
          infoWindow: const InfoWindow(title: 'My Location'),
        ),
      );
    }

    // ----add destination marker to map---- // 
    if (initialLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: initialLocation,
          icon: markerIcon,
          infoWindow: const InfoWindow(title: 'Destination'),
        ),
      );
    }

    // ----add additional markers to map---- //
    // if (additionalMarkers != null) {
    //   for (int i = 0; i < additionalMarkers.length; i++) {
    //     markers.add(
    //       Marker(
    //         markerId: MarkerId('additional_marker_$i'),
    //         position: additionalMarkers[i],
    //         icon: markerIcon,
    //         infoWindow: InfoWindow(title: 'Point ${i + 1}'),
    //       ),
    //     );
    //   }
    // }

    return markers;
  }
}
