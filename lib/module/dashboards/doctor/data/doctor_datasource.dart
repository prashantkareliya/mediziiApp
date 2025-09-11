import 'package:flutter/material.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/app_http.dart';

class DoctorDatasource extends HttpActions {

  Future<dynamic> getAllPatient({
    String? name,
    String? sex,
    String? blood,
    int? minAge,
    int? maxAge,
  }) async {
    final Map<String, dynamic> queryParams = {};

    if (name != null && name.isNotEmpty) queryParams['name'] = name;
    if (sex != null && sex.isNotEmpty) queryParams['sex'] = sex;
    if (blood != null && blood.isNotEmpty) queryParams['blood'] = blood;
    if (minAge != null) queryParams['minAge'] = minAge.toString();
    if (maxAge != null) queryParams['maxAge'] = maxAge.toString();

    final response = await getMethodWithQueryParam(
      ApiEndPoint.getAllPatient,
      queryParams: queryParams,
    );

    debugPrint("Get All Patient - $response");
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
    final response = await deleteMethodWithQueryParam(ApiEndPoint.doctorDelete(id));
    debugPrint("doctor delete -  $response");
    return response;
  }
}
