import 'package:flutter/rendering.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/app_http.dart';
import 'package:medizii/module/authentication/model/create_user_request.dart';

class AuthDatasource extends HttpActions {
  Future<dynamic> createUser({required CreateUserRequest createUserRequest}) async {
    final response = await postMethod(ApiEndPoint.createUser, data: createUserRequest.toJson());
    debugPrint("crate user ==== > $response");
    return response;
  }
}
