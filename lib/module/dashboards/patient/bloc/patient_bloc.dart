import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medizii/module/dashboards/doctor/model/delete_doctor_response.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_detail_request.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_request.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_response.dart';
import 'package:medizii/module/dashboards/patient/model/get_all_doctor_response.dart';
import 'package:medizii/module/dashboards/patient/model/get_booking_detail_response.dart';
import 'package:medizii/module/dashboards/patient/model/get_ride_history_response.dart';
import 'package:medizii/module/dashboards/patient/model/upload_document_response.dart';
import 'package:medizii/module/dashboards/patient/model/upload_report_request.dart';
import 'package:meta/meta.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final PatientRepository patientRepository;

  PatientBloc(this.patientRepository) : super(PatientInitial()) {
    on<PatientEvent>((event, emit) {});
    on<GetAllDoctorEvent>((event, emit) => _getAllDoctor(event, emit));

    on<DeletePatientEvent>((event, emit) => _deletePatient(event, emit));
    on<UploadReportImagesEvent>((event, emit) => _uploadReport(event, emit));
    on<EmsBookingEvent>((event, emit) => emsBooking(event, emit));
    on<BookingDetailEvent>((event, emit) => bookingDetail(event, emit));
    on<GetRideHistoryEvent>((event, emit) => getRideHistory(event, emit));

  }

  _getAllDoctor(GetAllDoctorEvent event, Emitter<PatientState> emit) async {
    emit(LoadingState(true));
    final response = await patientRepository.getAllDoctor();
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<GetAllDoctorResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  _deletePatient(DeletePatientEvent event, Emitter<PatientState> emit) async {
    emit(LoadingState(true));
    final response = await patientRepository.deletePatient(event.id);
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<DeleteDoctorResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  _uploadReport(UploadReportImagesEvent event, Emitter<PatientState> emit) async {
    emit(LoadingState(true));

    final response = await patientRepository.uploadReport(event.id, event.uploadReportRequest);

    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<UploadDocumentResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  emsBooking(EmsBookingEvent event, Emitter<PatientState> emit) async {
    emit(LoadingState(true));

    final response = await patientRepository.emsBooking(
      emsBookingRequest: event.emsBookingRequest,
    );

    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<EmsBookingResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  bookingDetail(BookingDetailEvent event, Emitter<PatientState> emit) async {
    emit(LoadingState(true));

    final response = await patientRepository.getBookingDetail(getBookingDetailRequest: event.getBookingDetailRequest);

    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<GetBookingDetailResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  getRideHistory(GetRideHistoryEvent event, Emitter<PatientState> emit) async {
    emit(LoadingState(true));
    final response = await patientRepository.getRideHistory(event.id);
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<GetRideHistoryResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }
}
