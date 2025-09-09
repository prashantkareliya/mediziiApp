part of 'technician_bloc.dart';

@immutable
sealed class TechnicianState {}

final class TechnicianInitial extends TechnicianState {}

///  loading state
class LoadingState extends TechnicianState {
  final bool isBusy;

  LoadingState(this.isBusy);
}

///  loaded state
class LoadedState<T> extends TechnicianState {
  final T data;

  LoadedState({required this.data});
}

///  failure state
class FailureState extends TechnicianState {
  final String error;

  FailureState(this.error);
}
