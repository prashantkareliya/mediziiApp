import 'package:flutter/cupertino.dart';
import 'package:medizii/module/authentication/model/create_user_request.dart';

@immutable
sealed class AuthEvent {}

//Contact us form event
class CreateUSerEvent extends AuthEvent {
  final CreateUserRequest createUserRequest;
  CreateUSerEvent(this.createUserRequest);
}
