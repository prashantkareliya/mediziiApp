
import 'package:flutter/material.dart';

@immutable
sealed class DoctorEvent {}

class GetPatientByIdEvent extends DoctorEvent {
  String id;
  GetPatientByIdEvent(this.id);
}

class GetAllPatientEvent extends DoctorEvent {
  final String? name;
  final String? sex;
  final String? blood;
  final int? minAge;
  final int? maxAge;

  GetAllPatientEvent({
    this.name,
    this.sex,
    this.blood,
    this.minAge,
    this.maxAge,
  });
}

class GetDoctorByIdEvent extends DoctorEvent {
  String id;
  GetDoctorByIdEvent(this.id);
}

class DeleteDoctorEvent extends DoctorEvent {
  String id;
  DeleteDoctorEvent(this.id);
}