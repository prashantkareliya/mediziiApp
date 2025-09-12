import 'package:medizii/constants/constants.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/http_actions/api_result.dart';
import 'package:medizii/http_actions/handle_api_error.dart';
import 'package:medizii/module/dashboards/Technician/data/technician_datasource.dart';
import 'package:medizii/module/dashboards/Technician/model/get_technician_by_id.dart';
import 'package:medizii/module/dashboards/Technician/model/tc_accept_reject_request.dart';
import 'package:medizii/module/dashboards/Technician/model/tc_accept_reject_response.dart';
import 'package:medizii/module/dashboards/doctor/model/delete_doctor_response.dart';

class TechnicianRepository {
  TechnicianRepository({required TechnicianDatasource technicianDatasource}) : _technicianDatasource = technicianDatasource;
  final TechnicianDatasource _technicianDatasource;

  Future<ApiResult<GetTechnicianByIdResponse>> getTechnicianById(String id) async {
    try {
      final result = await _technicianDatasource.getTechnicianById(id);

      GetTechnicianByIdResponse getTechnicianByIdResponse = GetTechnicianByIdResponse.fromJson(result);

      if (getTechnicianByIdResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: getTechnicianByIdResponse);
      } else {
        return ApiResult.failure(error: ErrorString.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<DeleteDoctorResponse>> deleteTechnician(String id) async {
    try {
      final result = await _technicianDatasource.deleteTechnician(id);

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

  Future<ApiResult<TechnicianAcceptRejectResponse>> emsBookingAccept({
    required TechnicianAcceptRejectRequest technicianAcceptRejectRequest,
  }) async {
    try {
      final result = await _technicianDatasource.emsAccept(technicianAcceptRejectRequest: technicianAcceptRejectRequest);

      TechnicianAcceptRejectResponse technicianAcceptRejectResponse = TechnicianAcceptRejectResponse.fromJson(result);

      if (technicianAcceptRejectResponse.success == ResponseStatus.failed) {
        return ApiResult.success(data: technicianAcceptRejectResponse);
      } else {
        return ApiResult.failure(error: technicianAcceptRejectResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<TechnicianAcceptRejectResponse>> emsBookingReject({
    required TechnicianAcceptRejectRequest technicianAcceptRejectRequest,
  }) async {
    try {
      final result = await _technicianDatasource.emsReject(technicianAcceptRejectRequest: technicianAcceptRejectRequest);

      TechnicianAcceptRejectResponse technicianAcceptRejectResponse = TechnicianAcceptRejectResponse.fromJson(result);

      if (technicianAcceptRejectResponse.success == ResponseStatus.failed) {
        return ApiResult.success(data: technicianAcceptRejectResponse);
      } else {
        return ApiResult.failure(error: technicianAcceptRejectResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
