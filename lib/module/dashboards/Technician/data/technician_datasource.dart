import 'package:flutter/material.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/app_http.dart';
import 'package:medizii/module/dashboards/Technician/model/tc_accept_reject_request.dart';

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

  Future<dynamic> emsAccept({required TechnicianAcceptRejectRequest technicianAcceptRejectRequest}) async {
    final response = await postMethod(ApiEndPoint.emsBookingAccept, data: technicianAcceptRejectRequest.toJson());
    debugPrint("Booking Accept -  $response");
    return response;
  }

  Future<dynamic> emsReject({required TechnicianAcceptRejectRequest technicianAcceptRejectRequest}) async {
    final response = await postMethod(ApiEndPoint.emsBookingReject, data: technicianAcceptRejectRequest.toJson());
    debugPrint("Booking Reject -  $response");
    return response;
  }

  Future<dynamic> getRideHistory(String id) async {
    final response = await getMethodWithQueryParam(ApiEndPoint.technicianRideHistory("68b588927332382a9925a6e6"));
    debugPrint("get ride history-  $response");
    return response;
  }
}