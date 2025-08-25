import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medizii/main.dart';
import 'package:medizii/screens/no_internet_screen.dart';
import 'app_exception.dart';

class ApiResponseHandler {
  static T handleResponse<T>(Response response) {
    final statusCode = response.statusCode;

    if (statusCode == 200 || statusCode == 201) {
      return response.data;
    }

    switch (statusCode) {
      case 400:
        throw AppException("Bad Request", statusCode: 400);
      case 401:
        throw AppException("Unauthorized", statusCode: 401);
      case 403:
        throw AppException("Forbidden", statusCode: 403);
      case 404:
        throw AppException("Not Found", statusCode: 404);
      case 500:
        throw AppException("Internal Server Error", statusCode: 500);
      default:
        throw AppException("Unexpected Error", statusCode: statusCode);
    }
  }

  static void handleDioError(DioException e) {
    // Check for network-related errors that should show no internet screen
    if (_shouldShowNoInternetScreen(e)) {
      _showNoInternetScreen();
      throw AppException("No Internet Connection");
    }

    if (e.type == DioExceptionType.connectionTimeout) {
      throw AppException("Connection Timeout");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      throw AppException("Receive Timeout");
    } else if (e.message == "No internet connection") {
      throw AppException("No Internet Connection");
    } else if (e.response != null) {
      throw AppException(
        e.response?.data['message'] ?? "Unknown Error",
        statusCode: e.response?.statusCode,
      );
    } else {
      throw AppException("Unexpected Error: ${e.error ?? ""}");
    }
  }

  /// Check if the error should trigger the no internet screen
  static bool _shouldShowNoInternetScreen(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.unknown ||
        e.message?.contains("No internet connection") == true ||
        e.message?.contains("Network is unreachable") == true ||
        e.message?.contains("Failed to connect") == true ||
        e.message?.contains("SocketException") == true;
  }

  /// Show the no internet screen
  static void _showNoInternetScreen() {
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
}
