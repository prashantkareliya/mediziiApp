part of 'doctor_bloc.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

///  loading state
class LoadingState extends DoctorState {
  final bool isBusy;

  LoadingState(this.isBusy);
}

///  loaded state
class LoadedState<T> extends DoctorState {
  final T data;

  LoadedState({required this.data});
}

///  failure state
class FailureState extends DoctorState {
  final String error;

  FailureState(this.error);
}
