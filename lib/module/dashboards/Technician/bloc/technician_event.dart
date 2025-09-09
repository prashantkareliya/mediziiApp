part of 'technician_bloc.dart';

@immutable
sealed class TechnicianEvent {}

class GetTechnicianByIdEvent extends TechnicianEvent {
  String id;

  GetTechnicianByIdEvent(this.id);
}

class DeleteTechnicianEvent extends TechnicianEvent {
  String id;

  DeleteTechnicianEvent(this.id);
}