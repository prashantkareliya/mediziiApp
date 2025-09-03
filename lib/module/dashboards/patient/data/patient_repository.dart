import 'package:medizii/constants/constants.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/http_actions/api_result.dart';
import 'package:medizii/http_actions/handle_api_error.dart';
import 'package:medizii/module/dashboards/doctor/model/delete_doctor_response.dart';
import 'package:medizii/module/dashboards/patient/data/patient_datasource.dart';
import 'package:medizii/module/dashboards/patient/model/get_all_doctor_response.dart';

import '../../doctor/model/get_patient_detail.dart';

class PatientRepository {
  PatientRepository({required PatientDatasource patientDatasource}) : _patientDatasource = patientDatasource;
  final PatientDatasource _patientDatasource;

  Future<ApiResult<GetAllDoctorResponse>> getAllDoctor() async {
    try {
      final result = await _patientDatasource.getAllDoctor();

      GetAllDoctorResponse getAllDoctorResponse = GetAllDoctorResponse.fromJson(result);

      if (getAllDoctorResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: getAllDoctorResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<GetAllPatientDetailResponse>> getDoctorById(String id) async {
    try {
      final result = await _patientDatasource.getPatientById(id);

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

  Future<ApiResult<DeleteDoctorResponse>> deletePatient(String id) async {
    try {
      final result = await _patientDatasource.deletePatient(id);

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
}
