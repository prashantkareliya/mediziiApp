import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/api_result.dart';
import 'package:medizii/module/authentication/data/datasource.dart';
import 'package:medizii/module/authentication/model/create_user_request.dart';
import 'package:medizii/module/authentication/model/create_user_response.dart';

class AuthRepository {
  AuthRepository({required AuthDatasource authDatasource}) : _authDatasource = authDatasource;
  final AuthDatasource _authDatasource;

  Future<ApiResult<CreateUserResponse>> contactUsForm({required CreateUserRequest createUserRequest}) async {
    final result = await _authDatasource.createUser(createUserRequest: createUserRequest);

    CreateUserResponse createUserResponse = CreateUserResponse.fromJson(result);

    if (createUserResponse.success == ResponseStatus.success) {
      return ApiResult.success(data: createUserResponse);
    } else {
      return ApiResult.failure(error: createUserResponse.message.toString());
    }
  }
}
