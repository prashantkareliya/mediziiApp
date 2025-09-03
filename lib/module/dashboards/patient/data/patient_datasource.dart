import 'package:flutter/material.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/app_http.dart';

class PatientDatasource extends HttpActions {
  Future<dynamic> getAllDoctor() async {
    final response = await getMethod(ApiEndPoint.getAllDoctor);
    debugPrint("Get All Doctor -  $response");
    return response;
  }

  Future<dynamic> getPatientById(String id) async {
    final response = await getMethodWithQueryParam(ApiEndPoint.getPatientDetail(id));
    debugPrint("patient get by id-  $response");
    return response;
  }

  Future<dynamic> deletePatient(String id) async {
    final response = await getMethodWithQueryParam(ApiEndPoint.patientDelete(id));
    debugPrint("Patient delete -  $response");
    return response;
  }
}
