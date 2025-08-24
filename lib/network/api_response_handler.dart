import 'package:dio/dio.dart';
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
}
