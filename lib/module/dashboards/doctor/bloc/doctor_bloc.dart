import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_repository.dart';
import 'package:medizii/module/dashboards/doctor/model/delete_doctor_response.dart';
import 'package:medizii/module/dashboards/doctor/model/get_all_doctor_response.dart';
import 'package:medizii/module/dashboards/doctor/model/get_doctor_by_id_response.dart';

import '../model/get_patient_detail.dart';
import 'doctor_event.dart';

part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository doctorRepository;

  DoctorBloc(this.doctorRepository) : super(DoctorInitial()) {
    on<DoctorEvent>((event, emit) {});
    on<GetPatientByIdEvent>((event, emit) => _getPatient(event, emit));
    on<GetAllPatientEvent>((event, emit) => _getAllPatient(event, emit));
    on<GetDoctorByIdEvent>((event, emit) => _getDoctor(event, emit));
    on<DeleteDoctorEvent>((event, emit) => _deleteDoctor(event, emit));
  }

  _getPatient(GetPatientByIdEvent event, Emitter<DoctorState> emit) async {
    emit(LoadingState(true));
    final response = await doctorRepository.getPatientById(event.id);
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<GetAllPatientDetailResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  _getAllPatient(GetAllPatientEvent event, Emitter<DoctorState> emit) async {
    emit(LoadingState(true));
    final response = await doctorRepository.getAllPatient();
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<GetAllPatientResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  _getDoctor(GetDoctorByIdEvent event, Emitter<DoctorState> emit) async {
    emit(LoadingState(true));
    final response = await doctorRepository.getDoctorById(event.id);
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<GetDoctorByIdResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  _deleteDoctor(DeleteDoctorEvent event, Emitter<DoctorState> emit) async {
    emit(LoadingState(true));
    final response = await doctorRepository.deleteDoctor(event.id);
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
}
