import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class OsmMapWidget extends StatefulWidget {
  final LatLng? initialCenter;
  final double initialZoom;
  final List<Marker>? markers;
  final bool showUserLocation;
  final Function(LatLng)? onMapTap;
  final Function(Marker)? onMarkerTap;

  const OsmMapWidget({
    Key? key,
    this.initialCenter,
    this.initialZoom = 13.0,
    this.markers,
    this.showUserLocation = true,
    this.onMapTap,
    this.onMarkerTap,
  }) : super(key: key);

  @override
  State<OsmMapWidget> createState() => _OsmMapWidgetState();
}

class _OsmMapWidgetState extends State<OsmMapWidget>
    with TickerProviderStateMixin {
  LatLng? _userLocation;
  final MapController _mapController = MapController();
  bool _isLoading = true;
  bool _isDarkMode = false;
  double _currentZoom = 13.0;

  @override
  void initState() {
    super.initState();
    _currentZoom = widget.initialZoom;
    if (widget.showUserLocation) {
      _getUserLocation();
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoading = false);
        _showPermissionDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      // Smooth animation to user location
      _mapController.move(_userLocation!, widget.initialZoom);
    } catch (e) {
      debugPrint('Error getting location: $e');
      setState(() => _isLoading = false);
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text(
          'Please enable location permission in settings to see your location on the map.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  String _getTileUrl() {
    return _isDarkMode
        ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png'
        : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  }

  void _recenterToUser() {
    if (_userLocation != null) {
      _mapController.move(_userLocation!, 15.0);
    } else {
      _getUserLocation();
    }
  }

  void _zoomIn() {
    setState(() => _currentZoom = (_currentZoom + 1).clamp(5.0, 18.0));
    _mapController.move(_mapController.center, _currentZoom);
  }

  void _zoomOut() {
    setState(() => _currentZoom = (_currentZoom - 1).clamp(5.0, 18.0));
    _mapController.move(_mapController.center, _currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Map
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: widget.initialCenter ?? LatLng(14.5995, 120.9842),
            initialZoom: widget.initialZoom,
            minZoom: 5.0,
            maxZoom: 18.0,
            onTap: (tapPosition, point) {
              widget.onMapTap?.call(point);
            },
            onPositionChanged: (position, hasGesture) {
              if (hasGesture) {
                setState(() => _currentZoom = position.zoom ?? _currentZoom);
              }
            },
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            // Base Map Tile Layer
            TileLayer(
              urlTemplate: _getTileUrl(),
              userAgentPackageName: 'com.ars.app',
              maxZoom: 19,
              subdomains: const ['a', 'b', 'c'],
              retinaMode: true,
            ),

            // Custom Markers Layer
            if (widget.markers != null && widget.markers!.isNotEmpty)
              MarkerLayer(
                markers: widget.markers!,
                rotate: false,
              ),

            // User Location Layer (Blue Pulsing Dot)
            if (_userLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _userLocation!,
                    width: 80,
                    height: 80,
                    child: TweenAnimationBuilder(
                      duration: const Duration(seconds: 2),
                      tween: Tween<double>(begin: 0.5, end: 1.0),
                      curve: Curves.easeInOut,
                      onEnd: () {
                        setState(() {});
                      },
                      builder: (context, double scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3 * scale),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.5),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),

        // Loading Overlay
        if (_isLoading)
          Container(
            color: Colors.black26,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),

        // Map Controls - Top Right
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              // Theme Toggle
              _MapControlButton(
                icon: _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                onPressed: () {
                  setState(() => _isDarkMode = !_isDarkMode);
                },
                tooltip: _isDarkMode ? 'Light Mode' : 'Dark Mode',
              ),
              const SizedBox(height: 8),
              // Zoom In
              _MapControlButton(
                icon: Icons.add,
                onPressed: _zoomIn,
                tooltip: 'Zoom In',
              ),
              const SizedBox(height: 8),
              // Zoom Out
              _MapControlButton(
                icon: Icons.remove,
                onPressed: _zoomOut,
                tooltip: 'Zoom Out',
              ),
            ],
          ),
        ),

        // Recenter Button - Bottom Right
        Positioned(
          bottom: 80,
          right: 16,
          child: _MapControlButton(
            icon: Icons.my_location,
            onPressed: _recenterToUser,
            tooltip: 'My Location',
            isPrimary: true,
          ),
        ),

        // Zoom Level Indicator - Bottom Left
        Positioned(
          bottom: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Zoom: ${_currentZoom.toStringAsFixed(1)}x',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final bool isPrimary;

  const _MapControlButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isPrimary ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : Colors.black87,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
