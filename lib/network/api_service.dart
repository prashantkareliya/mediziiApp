/*
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:medizii/constants/api_constants.dart';
import 'dio_client.dart';
import 'api_response_handler.dart';
import 'app_exception.dart';

class ApiService {
  final Dio _dio = DioClient.dio;
  final _baseurl = ApiConstants.baseUrl;

  Future<T?> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        _baseurl + endpoint,
        queryParameters: queryParams,
      );
      debugPrint("$endpoint API =================> $response");
      return ApiResponseHandler.handleResponse<T>(response);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return null;
    } catch (e) {
      throw AppException("Unexpected error: ${e.toString()}");
    }
  }

  Future<T?> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        _baseurl + endpoint,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      );
      debugPrint("$endpoint API =================> $response");
      return ApiResponseHandler.handleResponse<T>(response);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return null;
    } catch (e) {
      throw AppException("Unexpected error: ${e.toString()}");
    }
  }

  Future<T?> put<T>(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(_baseurl + endpoint, data: data);
      debugPrint("$endpoint API =================> $response");
      return ApiResponseHandler.handleResponse<T>(response);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return null;
    }
  }

  Future<T?> patch<T>(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.patch(_baseurl + endpoint, data: data);
      debugPrint("$endpoint API =================> $response");
      return ApiResponseHandler.handleResponse<T>(response);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return null;
    }
  }

  Future<T?> delete<T>(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(_baseurl + endpoint, data: data);
      debugPrint("$endpoint API =================> $response");
      return ApiResponseHandler.handleResponse<T>(response);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return null;
    }
  }
}
*/
