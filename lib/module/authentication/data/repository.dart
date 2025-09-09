import 'package:flutter/cupertino.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/http_actions/api_result.dart';
import 'package:medizii/http_actions/handle_api_error.dart';
import 'package:medizii/module/authentication/data/datasource.dart';
import 'package:medizii/module/authentication/model/create_user_request.dart';
import 'package:medizii/module/authentication/model/create_user_response.dart';
import 'package:medizii/module/authentication/model/forget_password_response.dart';
import 'package:medizii/module/authentication/model/hospitals_response.dart';
import 'package:medizii/module/authentication/model/login_request.dart';
import 'package:medizii/module/authentication/model/login_response.dart';
import 'package:medizii/module/authentication/model/nearest_hospital_response.dart';

class AuthRepository {
  AuthRepository({required AuthDatasource authDatasource}) : _authDatasource = authDatasource;
  final AuthDatasource _authDatasource;


  Future<ApiResult<CreateUserResponse>> createUser({
    required CreateUserRequest createUserRequest,
  }) async {
    // Determine endpoint based on role
    String endpoint;
    switch (createUserRequest.role?.toLowerCase()) {
      case 'doctor':
        endpoint = ApiEndPoint.createDoctor;
        break;
      case 'patient':
        endpoint = ApiEndPoint.createPatient;
        break;
      case 'technician':
        endpoint = ApiEndPoint.createTechnician;
        break;
      default:
        return ApiResult.failure(error: 'Invalid user role: ${createUserRequest.role}');
    }

    try {
      final result = await _authDatasource.createUser(
        endpoint: endpoint,
        createUserRequest: createUserRequest,
      );

      CreateUserResponse createUserResponse = CreateUserResponse.fromJson(result);

      if (createUserResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: createUserResponse);
      } else {
        return ApiResult.failure(error: createUserResponse.message.toString());
      }
    } catch (e) {
      return ApiResult.failure(error: 'Failed to create user: $e');
    }
  }


  //Login User
  Future<ApiResult<LoginResponse>> loginUser({
    required LoginRequest loginRequest,
    required String role,
  }) async {
    // Determine endpoint based on role
    String endpoint;
    switch (role.toLowerCase()) {
      case 'doctor':
        endpoint = ApiEndPoint.loginDoctor;
        break;
      case 'patient':
        endpoint = ApiEndPoint.loginPatient;
        break;
      case 'technician':
        endpoint = ApiEndPoint.loginTechnician;
        break;
      default:
        return ApiResult.failure(error: 'Invalid user role: $role');
    }

    try {
      final result = await _authDatasource.loginUser(
        endpoint: endpoint,
        loginRequest: loginRequest,
      );

      LoginResponse loginResponse = LoginResponse.fromJson(result);

      if (loginResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: loginResponse);
      } else {
        return ApiResult.failure(error: loginResponse.message ?? 'Login failed');
      }
    } catch (e) {
      return ApiResult.failure(error: 'Login failed: $e');
    }
  }

  Future<ApiResult<ForgetPasswordResponse>> forgetPassword({
    required Map<String, dynamic> requestData,
    required String role,
  }) async {
    // Determine endpoint based on role
    String endpoint;
    switch (role.toLowerCase()) {
      case 'doctor':
        endpoint = ApiEndPoint.forgetPasswordDoctor;
        break;
      case 'patient':
        endpoint = ApiEndPoint.forgetPasswordPatient;
        break;
      case 'technician':
        endpoint = ApiEndPoint.forgetPasswordTechnician;
        break;
      default:
        return ApiResult.failure(error: 'Invalid user role: $role');
    }

    try {
      final result = await _authDatasource.forgetPassword(
        endpoint: endpoint,
        requestData: requestData,
      );

      ForgetPasswordResponse forgetPasswordResponse = ForgetPasswordResponse.fromJson(result);

      if (forgetPasswordResponse.error == false) {
        return ApiResult.success(data: forgetPasswordResponse);
      } else {
        return ApiResult.failure(error: forgetPasswordResponse.message ?? 'Operation failed');
      }
    } catch (e) {
      return ApiResult.failure(error: 'Operation failed: $e');
    }
  }

  //get all hospital
  Future<ApiResult<HospitalResponse>> getHospitals() async {
    try {
      final result = await _authDatasource.getAllHospitals();

      HospitalResponse hospitalResponse = HospitalResponse.fromJson(result);

      if (hospitalResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: hospitalResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch(e){
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<GetNearestHospitalResponse>> getNearestHospital(String lat, String lang) async {
    try {
      final result = await _authDatasource.getNearestHospital(lat, lang);

      GetNearestHospitalResponse getNearestHospitalResponse = GetNearestHospitalResponse.fromJson(result);

      if (ResponseStatus.success == ResponseStatus.success) {
        return ApiResult.success(data: getNearestHospitalResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch (e, stack) {
      final message = HandleAPI.handleAPIError(e);
      debugPrintStack(stackTrace: stack, label: "@@@@@@@@@@@@@@@@@@@@$e", maxFrames: 5);
      return ApiResult.failure(error: message);
    }
  }
}
