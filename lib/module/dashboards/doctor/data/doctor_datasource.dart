import 'package:flutter/material.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/app_http.dart';

class DoctorDatasource extends HttpActions {

  Future<dynamic> getAllPatient() async {
    final response = await getMethod(ApiEndPoint.getAllPatient);
    debugPrint("Get All Patient -  $response");
    return response;
  }

  Future<dynamic> getPatientDetail(String id) async {
    final response = await getMethodWithQueryParam(ApiEndPoint.getPatientDetail(id));
    debugPrint("patient get by id-  $response");
    return response;
  }

  Future<dynamic> getDoctorById(String id) async {
    final response = await getMethodWithQueryParam(ApiEndPoint.getDoctorDetail(id));
    debugPrint("doctor get by id-  $response");
    return response;
  }

  Future<dynamic> deleteDoctor(String id) async {
    final response = await getMethodWithQueryParam(ApiEndPoint.doctorDelete(id));
    debugPrint("doctor delete -  $response");
    return response;
  }
}
