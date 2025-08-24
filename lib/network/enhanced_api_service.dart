import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'api_response_handler.dart';
import 'api_result.dart';
import 'dio_client.dart';

class EnhancedApiService {
  final Dio _dio = DioClient.dio;

  /// GET request with ApiResult
  Future<ApiResult<T>> get<T>(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      debugPrint("$endpoint API =================> $response");
      final data = ApiResponseHandler.handleResponse<T>(response);
      return ApiResult.success(data);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return ApiResult.error("Network error occurred");
    } catch (e) {
      return ApiResult.error("Unexpected error: ${e.toString()}");
    }
  }

  /// POST request with ApiResult
  Future<ApiResult<T>> post<T>(String endpoint, {dynamic data, Map<String, String>? headers}) async {
    try {
      final response = await _dio.post(endpoint, data: data, options: headers != null ? Options(headers: headers) : null);
      debugPrint("$endpoint API =================> $response");
      final result = ApiResponseHandler.handleResponse<T>(response);
      return ApiResult.success(result);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return ApiResult.error("Network error occurred");
    } catch (e) {
      return ApiResult.error("Unexpected error: ${e.toString()}");
    }
  }

  /// PUT request with ApiResult
  Future<ApiResult<T>> put<T>(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      debugPrint("$endpoint API =================> $response");
      final result = ApiResponseHandler.handleResponse<T>(response);
      return ApiResult.success(result);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return ApiResult.error("Network error occurred");
    } catch (e) {
      return ApiResult.error("Unexpected error: ${e.toString()}");
    }
  }

  /// PATCH request with ApiResult
  Future<ApiResult<T>> patch<T>(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      debugPrint("$endpoint API =================> $response");
      final result = ApiResponseHandler.handleResponse<T>(response);
      return ApiResult.success(result);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return ApiResult.error("Network error occurred");
    } catch (e) {
      return ApiResult.error("Unexpected error: ${e.toString()}");
    }
  }

  /// DELETE request with ApiResult
  Future<ApiResult<T>> delete<T>(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      debugPrint("$endpoint API =================> $response");
      final result = ApiResponseHandler.handleResponse<T>(response);
      return ApiResult.success(result);
    } on DioException catch (e) {
      ApiResponseHandler.handleDioError(e);
      return ApiResult.error("Network error occurred");
    } catch (e) {
      return ApiResult.error("Unexpected error: ${e.toString()}");
    }
  }
}
