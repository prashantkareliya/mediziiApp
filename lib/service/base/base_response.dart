
import 'base_model.dart';

class BaseResponse<T extends BaseModel?> {
  List<T?>? dataList;
  String? dataStr;

  String? message;
  String? statusCode;
  String? errorMessage;
  dynamic errorDetails;

  bool? isSuccess = false;
  dynamic actualData;

  T? get getData => dataList?.firstOrNull;
  bool get getIsSuccess => isSuccess ?? false;

  BaseResponse({this.message, this.statusCode, this.isSuccess, this.errorMessage, this.errorDetails});

  factory BaseResponse.fromJson(Map<String, dynamic> json, BaseModel? baseModel) {
    final baseResponse = BaseResponse<T>();

    // Handle success/failure flag
    baseResponse.isSuccess = json['success'] as bool? ?? false;

    if (baseResponse.isSuccess == true) {
      // ✅ Handle success case
      final rawData = json['data'];
      baseResponse.actualData = rawData;

      if (baseModel != null && rawData != null) {
        if (rawData is List) {
          baseResponse.dataList = rawData.map<T?>((x) => baseModel.fromJson(x) as T?).toList();
        } else if (rawData is Map<String, dynamic>) {
          baseResponse.dataList = [baseModel.fromJson(rawData) as T?];
        }
      } else if (rawData is String) {
        baseResponse.dataStr = rawData;
      }
    } else {
      // ❌ Handle error case
      final errorObj = json['error'];
      if (errorObj is Map<String, dynamic>) {
        baseResponse.errorMessage = errorObj['message']?.toString();
        baseResponse.errorDetails = errorObj['details'];
      }

      // fallback message
      baseResponse.message = baseResponse.errorMessage ?? 'Something went wrong';
    }

    // Optional fields
    baseResponse.statusCode = (json['statusCode'] ?? json['status'])?.toString();
    return baseResponse;
  }
}
