import 'package:flutter/rendering.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/app_http.dart';
import 'package:medizii/module/authentication/model/create_user_request.dart';
import 'package:medizii/module/authentication/model/login_request.dart';

class AuthDatasource extends HttpActions {
  Future<dynamic> createUser({
    required CreateUserRequest createUserRequest,
    required String endpoint,
  }) async {
    final response = await postMethod(endpoint, data: createUserRequest.toJson());
    debugPrint("Create user response: $response");
    return response;
  }

  Future<dynamic> loginUser({
    required LoginRequest loginRequest,
    required String endpoint,
  }) async {
    final response = await postMethod(endpoint, data: loginRequest.toJson());
    debugPrint("Login response: $response");
    return response;
  }


  Future<dynamic> forgetPassword({
    required Map<String, dynamic> requestData,
    required String endpoint,
  }) async {
    final response = await postMethod(endpoint, data: requestData);
    debugPrint("Forget password response: $response");
    return response;
  }

  getAllHospitals() async {
    final response = await getMethod(ApiEndPoint.getAllHospital);
    debugPrint("get Hospitals ==== > $response");
    return response;
  }

  Future<dynamic> getNearestHospital(String lat, String lang) async {
    final response = await getMethodWithQueryParam(ApiEndPoint.getNearestHospital(lat, lang));
    debugPrint("Nearest Hospital -  $response");
    return response;
  }

  getAboutUs() async {
    final response = await getMethod(ApiEndPoint.getAboutUs);
    debugPrint("getAboutUs ==== > $response");
    return response;
  }

  getContactUs() async {
    final response = await getMethod(ApiEndPoint.getContactUs);
    debugPrint("getContactUs ==== > $response");
    return response;
  }

  getPrivacyOPolicy() async {
    final response = await getMethod(ApiEndPoint.getPrivacyPolicy);
    debugPrint("getPrivacyPolicy ==== > $response");
    return response;
  }
}
