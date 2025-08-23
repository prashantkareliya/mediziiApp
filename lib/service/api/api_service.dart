import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medizii/constants/constants.dart';

import 'interceptor/api_interceptor.dart';

class ApiService {
  late dio.Dio _dio;

  ApiService() {
    _dio = dio.Dio(dio.BaseOptions(baseUrl: Constants.of().endpoint));

    _dio.options.receiveDataWhenStatusError = true;
    _dio.options.sendTimeout = const Duration(milliseconds: 60000);
    _dio.options.connectTimeout = const Duration(milliseconds: 60000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 60000);

    _dio.interceptors.add(internetCheckInterceptor);
    /**
     * set auth token if it exists in local
     */
  }

  Future<dio.Response<T>> get<T>({required String endPoint, Map<String, dynamic>? queryParams, bool isCompleteUrl = false}) async {
    try {
      return isCompleteUrl
          ? await _dio.getUri(Uri(path: endPoint, queryParameters: queryParams))
          : await _dio.get(endPoint, queryParameters: queryParams);
    } catch (error) {
      debugPrint('Network error: $error');
      rethrow;
    }
  }

  Future<dio.Response<T>> post<T>({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    bool isCompleteUrl = false,
  }) async {
    try {
      return isCompleteUrl
          ? await _dio.postUri(
            Uri(path: endPoint, queryParameters: queryParams),
            data: data,
            options: data is FormData ? dio.Options(contentType: dio.Headers.formUrlEncodedContentType) : null,
          )
          : await _dio.post(
            endPoint,
            queryParameters: queryParams,
            data: data,
            options: data is FormData ? dio.Options(contentType: dio.Headers.formUrlEncodedContentType) : null,
          );
    } catch (error) {
      debugPrint('Network error: $error');
      rethrow;
    }
  }

  Future<dio.Response> download<T>({required String url, required String filePath}) async {
    return await _dio.download(url, filePath);
  }

  Future<dio.Response<T>> delete<T>({required String url, data, Map<String, dynamic>? queryParams, bool isCompleteUrl = false}) async {
    try {
      return isCompleteUrl
          ? await _dio.deleteUri(Uri(path: url, queryParameters: queryParams), data: data)
          : await _dio.delete(url, queryParameters: queryParams, data: data);
    } catch (error) {
      debugPrint('Network error: $error');
      rethrow;
    }
  }

  Future<dio.Response<T>> patch<T>({required String url, data, Map<String, dynamic>? queryParams, bool isCompleteUrl = false}) async {
    try {
      return isCompleteUrl
          ? await _dio.patchUri(Uri(path: url, queryParameters: queryParams), data: data)
          : await _dio.patch(url, queryParameters: queryParams, data: data);
    } catch (error) {
      debugPrint('Network error: $error');
      rethrow;
    }
  }

  // void setAuthToken(String token) {
  //   if (token.isNotEmpty) {
  //     _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
  //   }
  //   _dio.options.headers.addAll({'Authentication': ApiConstants.basicToken});
  // }
}
