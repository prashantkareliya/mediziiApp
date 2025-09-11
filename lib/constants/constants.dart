import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants({required this.endpoint});

  factory Constants.of() {
    if (_instance != null) return _instance!;
    _instance = Constants._prd();
    return _instance!;
  }

  factory Constants._prd() {
    return const Constants(
      ///Base URl
      endpoint: 'https://medizii.onrender.com/', //  staging server
    );
  }

  static Constants? _instance;
  final String endpoint;
}

class ResponseStatus {
  static const bool failed = true;
  static const bool success = false;
}

class ApiEndPoint {
  //POST API endpoint

  static const String createDoctor = "doctor/create";
  static const String createPatient = "patient/create";
  static const String createTechnician = "technician/create";

  static const String loginDoctor = "doctor/login";
  static const String loginPatient = "patient/login";
  static const String loginTechnician = "technician/login";

  static const String forgetPasswordDoctor = "doctor/forget";
  static const String forgetPasswordPatient = "patient/forget";
  static const String forgetPasswordTechnician = "technician/forget";

  static const String updateDoctor = "doctor/update/id";
  static const String updatePatient = "patient/update/id";
  static const String updateTechnician = "technician/update/id";
  static const String emsBooking = "booking/request";
  static const String emsBookingAccept = "booking/accept";
  static const String emsBookingReject = "booking/reject";

  //DELETE API endpoint
  static const String deleteDoctor = "doctor/delete/id";
  static const String deletePatient = "patient/delete/id";
  static const String deleteTechnician = "technician/delete/id";

  //GET API endpoint


  static String getDoctorDetail(String id) => "doctor/detail/$id";
  static String getPatientDetail(String id) => "patient/detail/$id";
  static String getTechnicianDetail(String id) => "technician/detail/$id";
  static String doctorDelete(String id) => "doctor/delete/$id";
  static String patientDelete(String id) => "patient/delete/$id";
  static String technicianDelete(String id) => "technician/delete/$id";


  static String uploadReport(String id) => "report/upload/$id";




  static const String getAllDoctor = "doctor/detail/all";
  static const String getAllHospital = "hospital/all";
  static const String getAllPatient = "patient/detail/all";
  static const String getAllTechnician = "technician/detail/all";

  static String getNearestHospital(String lat, String lang) => "patient/nearest-hospital?lng=$lat&lat=$lang";
}
