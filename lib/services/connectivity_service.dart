import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final StreamController<bool> _connectivityController =
      StreamController<bool>.broadcast();

  /// Stream to listen to connectivity changes
  Stream<bool> get connectivityStream => _connectivityController.stream;

  /// Current connectivity status
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  /// Initialize the connectivity service
  Future<void> initialize() async {
    // Check initial connectivity
    await _checkConnectivity();

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final hasConnection = results.any(
        (result) => result != ConnectivityResult.none,
      );
      _isConnected = hasConnection;
      _connectivityController.add(_isConnected);

      debugPrint(
        'Connectivity changed: ${results.map((r) => r.name).join(', ')}',
      );
    });
  }

  /// Check current connectivity status
  Future<bool> checkConnectivity() async {
    await _checkConnectivity();
    return _isConnected;
  }

  Future<void> _checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _isConnected = results.any((result) => result != ConnectivityResult.none);
      _connectivityController.add(_isConnected);
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      _isConnected = false;
      _connectivityController.add(false);
    }
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivityController.close();
  }
}
