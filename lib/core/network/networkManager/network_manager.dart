import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  final Connectivity _connectivity = Connectivity();

  // Check if device is currently connected to internet
  Future<bool> isConnected() async {
    final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  // Stream to listen to connectivity changes
  Stream<List<ConnectivityResult>> get connectionStream => _connectivity.onConnectivityChanged;
}
