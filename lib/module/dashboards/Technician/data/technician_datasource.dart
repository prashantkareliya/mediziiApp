import 'package:flutter/material.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/app_http.dart';

class TechnicianDatasource extends HttpActions {
  Future<dynamic> getTechnicianById(String id) async {
    final response = await getMethodWithQueryParam(ApiEndPoint.getTechnicianDetail(id));
    debugPrint("technician get by id-  $response");
    return response;
  }

  Future<dynamic> deleteTechnician(String id) async {
    final response = await deleteMethodWithQueryParam(ApiEndPoint.technicianDelete(id));
    debugPrint("technician delete -  $response");
    return response;
  }
}