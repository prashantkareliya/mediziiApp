import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medizii/main.dart';
import 'package:medizii/screens/no_internet_screen.dart';

class NetworkErrorInterceptor extends Interceptor {
  bool _isNoInternetScreenShown = false;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if this is a network-related error
    if (_isNetworkError(err) && !_isNoInternetScreenShown) {
      _isNoInternetScreenShown = true;
      _showNoInternetScreen();
    }

    // Continue with the error handling
    super.onError(err, handler);
  }

  /// Check if the error is network-related
  bool _isNetworkError(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.unknown ||
        err.message?.contains("No internet connection") == true ||
        err.message?.contains("Network is unreachable") == true ||
        err.message?.contains("Failed to connect") == true ||
        err.message?.contains("SocketException") == true ||
        err.message?.contains("HandshakeException") == true ||
        err.message?.contains("CertificateException") == true;
  }

  /// Show the no internet screen
  void _showNoInternetScreen() {
    try {
      // Use a post-frame callback to ensure the navigation happens after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigationService.pushReplacement(const NoInternetScreen());
      });
    } catch (e) {
      // If navigation fails, just log it
      print('Failed to show no internet screen: $e');
    }
  }

  /// Reset the flag when internet is back
  void resetNoInternetScreenFlag() {
    _isNoInternetScreenShown = false;
  }
}
