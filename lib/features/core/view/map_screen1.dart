import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_ease/features/core/model/destination_model.dart';
import 'package:travel_ease/features/core/provider/map_controller.dart';

class MapScreen extends StatefulWidget {
  final Destination? destination;
  final List<LatLng>? additionalMarkers;
  final String mapTitle;
  final bool enableAddMarkers;
  final bool showCurrentLocation;

  const MapScreen({
    super.key,
    this.destination,
    this.additionalMarkers,
    this.mapTitle = 'Map View',
    this.enableAddMarkers = false,
    this.showCurrentLocation = true,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      await _mapController.initializeMap(
        destination: widget.destination,
        additionalMarkers: widget.additionalMarkers,
        showCurrentLocation: widget.showCurrentLocation,
        // enableAddMarkers: widget.enableAddMarkers,
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing map: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mapTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _mapController.mapType == MapType.normal
                  ? Icons.satellite
                  : Icons.map,
            ),
            onPressed: () {
              setState(() {
                _mapController.toggleMapType();
              });
            },
          ),
        ],
      ),
      body: _mapController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  mapType: _mapController.mapType,
                  onMapCreated: (controller) {
                    _mapController.onMapCreated(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: widget.destination?.location ??
                        _mapController.currentLocation ??
                        const LatLng(0, 0),
                    zoom: 15.0,
                  ),
                  markers: _mapController.markers,
                  polylines: _mapController.polylines,
                  myLocationEnabled: widget.showCurrentLocation,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                ),
                if (widget.showCurrentLocation)
                  Positioned(
                    bottom: 20,
                    right: 60,
                    child: IconButton(
                      icon: const Icon(Icons.my_location_outlined, size: 45),
                      onPressed: _mapController.goToCurrentLocation,
                    ),
                  ),
                if (_mapController.distanceInKm != null)
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 30,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          'Distance: ${_mapController.distanceInKm!.toStringAsFixed(2)} km',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
