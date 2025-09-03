import 'package:flutter/cupertino.dart';
import 'package:medizii/module/authentication/model/create_user_request.dart';
import 'package:medizii/module/authentication/model/forget_password_request.dart';
import 'package:medizii/module/authentication/model/login_request.dart';

@immutable
sealed class AuthEvent {}

// 4. Simplified Event
class CreateUserEvent extends AuthEvent {
  final CreateUserRequest createUserRequest;

  CreateUserEvent(this.createUserRequest);
}


class LoginUserEvent extends AuthEvent {
  final LoginRequest loginRequest;
  final String role;

  LoginUserEvent(this.loginRequest, this.role);
}

class SendOtpEvent extends AuthEvent {
  final ForgetPasswordRequest forgetPasswordRequest;
  final String role;

  SendOtpEvent(this.forgetPasswordRequest, this.role);
}

class FetchHospitalsEvent extends AuthEvent {
  FetchHospitalsEvent();
}
