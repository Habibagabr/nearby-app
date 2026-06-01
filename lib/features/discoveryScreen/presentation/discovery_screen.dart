import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  UnityWidgetController? _unityWidgetController;
  StreamSubscription<Position>? _locationSubscription;
  bool _unityReady = false;

  // ─── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _initLocationStream();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _unityWidgetController?.dispose();
    super.dispose();
  }

  // ─── Permissions ──────────────────────────────────────────────────────────

  Future<bool> _requestPermissions() async {
    final camera = await Permission.camera.request();
    final location = await Permission.location.request();
    return camera.isGranted && location.isGranted;
  }

  // ─── Location ─────────────────────────────────────────────────────────────

  Future<void> _initLocationStream() async {
    final granted = await _requestPermissions();
    if (!granted) {
      if (kDebugMode) print('Permissions denied');
      return;
    }

    final locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 5,               // Flutter emits every 5m moved
      // Unity does its own 50m threshold check
    );

    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(_onLocationUpdate);
  }

  void _onLocationUpdate(Position position) {
    if (!_unityReady || _unityWidgetController == null) return;

    final payload = jsonEncode({
      'lat': position.latitude,
      'lng': position.longitude,
    });

    _unityWidgetController!.postMessage(
      'ARBridge',          // Unity GameObject name
      'SetUserLocation',   // Unity method name
      payload,
    );

    if (kDebugMode) print('Sent to Unity: $payload');
  }

  // ─── Unity Callbacks ──────────────────────────────────────────────────────

  void _onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    setState(() => _unityReady = true);

    // Location stream is already running — it will start sending
    // as soon as _unityReady flips to true
  }

  void _onUnityMessage(dynamic message) {
    if (kDebugMode) print('Received from Unity: $message');

    try {
      final data = jsonDecode(message as String);
      // _handlePinTapped(data);
    } catch (e) {
      if (kDebugMode) print('Failed to parse Unity message: $e');
    }
  }

  // void _handlePinTapped(Map<String, dynamic> place) {
  //   // Navigate to place detail screen
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => PlaceDetailScreen(place: place),
  //     ),
  //   );
  // }

  // ─── UI ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full screen Unity AR view
          UnityWidget(
            onUnityCreated: _onUnityCreated,
            onUnityMessage: _onUnityMessage,
            fullscreen: true,
          ),

          // Optional: loading indicator until Unity is ready
          if (!_unityReady)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}