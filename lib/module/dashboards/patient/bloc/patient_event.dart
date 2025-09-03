part of 'patient_bloc.dart';

@immutable
sealed class PatientEvent {}


class GetAllDoctorEvent extends PatientEvent {
  GetAllDoctorEvent();
}

class GetPatientByIdEvent extends PatientEvent {
  String id;
  GetPatientByIdEvent(this.id);
}

class DeletePatientEvent extends PatientEvent {
  String id;
  DeletePatientEvent(this.id);
}