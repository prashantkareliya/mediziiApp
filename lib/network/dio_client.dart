import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'interceptors/internet_check_interceptor.dart';
import 'interceptors/auth_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.addAll([InternetCheckInterceptor(), AuthInterceptor()]);

  static Dio get dio => _dio;
}
