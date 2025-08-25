import 'package:flutter/material.dart';
import 'package:medizii/services/connectivity_service.dart';
import 'package:medizii/screens/no_internet_screen.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _isConnected = _connectivityService.isConnected;

    // Listen to connectivity changes
    _connectivityService.connectivityStream.listen((isConnected) {
      if (mounted) {
        setState(() {
          _isConnected = isConnected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      return const NoInternetScreen();
    }

    return widget.child;
  }

  /// For testing purposes - manually trigger no internet screen
  static void showNoInternetScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const NoInternetScreen()),
    );
  }
}
