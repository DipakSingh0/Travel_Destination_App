// ignore_for_file: use_build_context_synchronously

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_anim/imports.dart';
import 'package:hero_anim/features/core/provider/map_controller.dart';

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
  late final MapController _mapController;

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
        enableAddMarkers: widget.enableAddMarkers,
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _addMarkerAtTapPosition(LatLng position) async {
    if (!_mapController.canAddMarkers) return;

    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Marker'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter marker name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _mapController.addMarker(position, controller.text);
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mapTitle),
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
          if (widget.enableAddMarkers)
            IconButton(
              icon: Icon(
                _mapController.canAddMarkers
                    ? Icons.location_on
                    : Icons.location_off,
                color: _mapController.canAddMarkers ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _mapController.toggleMarkerMode();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _mapController.canAddMarkers
                          ? 'Tap on the map to add markers'
                          : 'Marker-adding disabled',
                    ),
                  ),
                );
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
                  onMapCreated: _mapController.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: widget.destination?.location ??
                        _mapController.currentLocation ??
                        const LatLng(0, 0),
                    zoom: 15.0,
                  ),
                  markers: _mapController.markers,
                  onTap: _addMarkerAtTapPosition,
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
              ],
            ),
    );
  }
}

