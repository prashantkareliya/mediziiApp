import 'package:dio/dio.dart';
import 'package:medizii/local/hive_service.dart';

class AuthInterceptor extends Interceptor {
  final HiveService _hiveService = HiveService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _hiveService.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid, clear it
      await _hiveService.deleteToken();
    }

    super.onError(err, handler);
  }
}
