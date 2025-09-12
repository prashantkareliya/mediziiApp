import 'package:flutter/material.dart';
import 'package:medizii/constants/constants.dart';
import 'package:medizii/http_actions/app_http.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_detail_request.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_request.dart';
import 'package:medizii/module/dashboards/patient/model/upload_report_request.dart';

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
    final response = await deleteMethodWithQueryParam(ApiEndPoint.patientDelete(id));
    debugPrint("Patient delete -  $response");
    return response;
  }

  Future<dynamic> uploadReport(String id, UploadReportRequest? uploadReportRequest) async {
    final response = await postMultiPartMethod(ApiEndPoint.uploadReport(id), data: await uploadReportRequest!.toJson());
    debugPrint("Upload Report -  $response");
    return response;
  }

  Future<dynamic> emsBooking({required EmsBookingRequest emsBookingRequest}) async {
    final response = await postMethod(ApiEndPoint.emsBooking, data: emsBookingRequest.toJson());
    debugPrint("ems booking -  $response");
    return response;
  }

  Future<dynamic> getBookingDetail({required GetBookingDetailRequest getBookingDetailRequest}) async {
    final response = await getMethodWithBody(ApiEndPoint.getEmsBookingDetail, body: getBookingDetailRequest.toJson());
    debugPrint("ems booking detail-  $response");
    return response;
  }
}
