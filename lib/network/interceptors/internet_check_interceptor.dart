import 'package:dio/dio.dart';
import 'package:medizii/main.dart';
import 'package:medizii/services/connectivity_service.dart';

class InternetCheckInterceptor extends Interceptor {
  bool _isNoInternetScreenShown = false;
  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await _connectivityService.checkConnectivity();

    if (!isConnected) {
      if (!_isNoInternetScreenShown) {
        _isNoInternetScreenShown = true;
        // The ConnectivityWrapper will handle showing the NoInternetScreen
      }
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: "No internet connection",
        ),
      );
    } else {
      // Internet is available, reset the flag
      _isNoInternetScreenShown = false;
    }

    super.onRequest(options, handler);
  }
}
