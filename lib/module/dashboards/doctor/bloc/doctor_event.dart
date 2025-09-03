
import 'package:flutter/material.dart';

@immutable
sealed class DoctorEvent {}

class GetPatientByIdEvent extends DoctorEvent {
  String id;
  GetPatientByIdEvent(this.id);
}

class GetAllPatientEvent extends DoctorEvent {
  GetAllPatientEvent();
}

class GetDoctorByIdEvent extends DoctorEvent {
  String id;
  GetDoctorByIdEvent(this.id);
}

class DeleteDoctorEvent extends DoctorEvent {
  String id;
  DeleteDoctorEvent(this.id);
}