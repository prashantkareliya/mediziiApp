import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:medizii/service/base/base_model.dart';
import 'package:medizii/service/base/base_response.dart';
import 'api_service.dart';

mixin class ApiCaller {
  int apiRetryCount = 0;
  ApiService apiService = ApiService();

  Future<BaseResponse<T?>> executeApiCall<T extends BaseModel>({
    String? endPoint,
    Map<String, dynamic>? reqData,
    Function(String)? onApiError,
    BaseModel? baseModel,
    MethodEnum method = MethodEnum.post,
  }) async {
    try {
      apiRetryCount++;
      var data = ((method == MethodEnum.post)
              ? (await apiService.post(endPoint: endPoint ?? '', data: reqData ?? {}))
              : (await apiService.get(endPoint: endPoint ?? '')))
          .data;
      final baseResponse = BaseResponse<T>.fromJson(data, baseModel);

      if (baseResponse.isSuccess ?? false) {
        return baseResponse;
      } else {
        if (onApiError != null) onApiError(baseResponse.message ?? '');
        apiRetryCount = 0;
        return baseResponse;
      }
    } catch (e,stack) {
      debugPrintStack(stackTrace: stack);
      _handleApiError(e, onApiError);
    }
    return BaseResponse<T?>(
      isSuccess: false,
      statusCode: '500',
      message: 'somethingWentWrong',
    );
  }

  void _handleApiError(e, Function(String)? onApiError) {
    var message = 'somethingWentWrong';
    if (e is DioException) {
      if (e.error != null) {
        message = (e.error).toString();
      } else {
        message = 'Something went wrong'; //e.response?.data['error'];
      }
    } else if (e is HttpException) {
      message = e.message;
    }
    debugPrint(e.toString());
    if (onApiError != null) onApiError(message);
  }
}

enum MethodEnum { get, post }
