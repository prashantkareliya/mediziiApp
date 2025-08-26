import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

///  loading state
class LoadingState extends AuthState {
  final bool isBusy;

  LoadingState(this.isBusy);
}

///  loaded state
class LoadedState<T> extends AuthState {
  final T data;

  LoadedState({required this.data});
}

///  failure state
class FailureState extends AuthState {
  final String error;

  FailureState(this.error);
}
