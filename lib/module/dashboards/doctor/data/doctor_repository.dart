import 'package:medizii/constants/constants.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/http_actions/api_result.dart';
import 'package:medizii/http_actions/handle_api_error.dart';
import 'package:medizii/module/dashboards/doctor/model/delete_doctor_response.dart';
import 'package:medizii/module/dashboards/doctor/model/get_all_doctor_response.dart';
import 'package:medizii/module/dashboards/doctor/model/get_doctor_by_id_response.dart';
import 'package:medizii/module/dashboards/doctor/model/get_patient_detail.dart';
import 'package:medizii/module/dashboards/doctor/model/get_recent_patient_response.dart';

import 'doctor_datasource.dart';

class DoctorRepository {
  DoctorRepository({required DoctorDatasource doctorDatasource}) : _doctorDatasource = doctorDatasource;
  final DoctorDatasource _doctorDatasource;

  Future<ApiResult<GetAllPatientDetailResponse>> getPatientById(String id) async {
    try {
      final result = await _doctorDatasource.getPatientDetail(id);

      GetAllPatientDetailResponse getAllPatientDetailResponse = GetAllPatientDetailResponse.fromJson(result);

      if (getAllPatientDetailResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: getAllPatientDetailResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<GetAllPatientResponse>> getAllPatient({
    String? name,
    String? sex,
    String? blood,
    int? minAge,
    int? maxAge,
  }) async {
    try {
      final result = await _doctorDatasource.getAllPatient(
        name: name,
        sex: sex,
        blood: blood,
        minAge: minAge,
        maxAge: maxAge,
      );

      GetAllPatientResponse getAllPatientResponse = GetAllPatientResponse.fromJson(result);

      if (getAllPatientResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: getAllPatientResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<GetDoctorByIdResponse>> getDoctorById(String id) async {
    try {
      final result = await _doctorDatasource.getDoctorById(id);

      GetDoctorByIdResponse getDoctorByIdResponse = GetDoctorByIdResponse.fromJson(result);

      if (getDoctorByIdResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: getDoctorByIdResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<DeleteDoctorResponse>> deleteDoctor(String id) async {
    try {
      final result = await _doctorDatasource.deleteDoctor(id);

      DeleteDoctorResponse deleteDoctorResponse = DeleteDoctorResponse.fromJson(result);

      if (deleteDoctorResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: deleteDoctorResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<GetRecentPatientResponse>> recentPatient() async {
    try {
      final result = await _doctorDatasource.getRecentPatient();

      GetRecentPatientResponse getRecentPatientResponse = GetRecentPatientResponse.fromJson(result);

      if (getRecentPatientResponse.success == ResponseStatus.failed) {
        return ApiResult.success(data: getRecentPatientResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
