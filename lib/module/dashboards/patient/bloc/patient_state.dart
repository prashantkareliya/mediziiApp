part of 'patient_bloc.dart';

@immutable
sealed class PatientState {}

final class PatientInitial extends PatientState {}

///  loading state
class LoadingState extends PatientState {
  final bool isBusy;

  LoadingState(this.isBusy);
}

///  loaded state
class LoadedState<T> extends PatientState {
  final T data;

  LoadedState({required this.data});
}

///  failure state
class FailureState extends PatientState {
  final String error;

  FailureState(this.error);
}
