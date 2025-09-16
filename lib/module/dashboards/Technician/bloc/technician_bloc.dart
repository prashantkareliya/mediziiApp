import 'package:bloc/bloc.dart';
import 'package:medizii/module/dashboards/Technician/data/technician_repository.dart';
import 'package:medizii/module/dashboards/Technician/model/get_technician_by_id.dart';
import 'package:medizii/module/dashboards/Technician/model/tc_accept_reject_request.dart';
import 'package:medizii/module/dashboards/Technician/model/tc_accept_reject_response.dart';
import 'package:medizii/module/dashboards/doctor/model/delete_doctor_response.dart';
import 'package:medizii/module/dashboards/patient/model/get_ride_history_response.dart';
import 'package:meta/meta.dart';

part 'technician_event.dart';
part 'technician_state.dart';

class TechnicianBloc extends Bloc<TechnicianEvent, TechnicianState> {
  final TechnicianRepository technicianRepository;

  TechnicianBloc(this.technicianRepository) : super(TechnicianInitial()) {
    on<TechnicianEvent>((event, emit) {});

    on<GetTechnicianByIdEvent>((event, emit) => _getTechnician(event, emit));
    on<DeleteTechnicianEvent>((event, emit) => _deleteTechnician(event, emit));
    on<EmsBookingAcceptEvent>((event, emit) => emsBookingAccept(event, emit));
    on<EmsBookingRejectEvent>((event, emit) => emsBookingReject(event, emit));
    on<GetRideHistoryEvent>((event, emit) => getRideHistory(event, emit));

  }

  _getTechnician(GetTechnicianByIdEvent? event, Emitter<TechnicianState> emit) async {
    emit(LoadingState(true));
    final response = await technicianRepository.getTechnicianById(event!.id);
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<GetTechnicianByIdResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  _deleteTechnician(DeleteTechnicianEvent event, Emitter<TechnicianState> emit) async {
    emit(LoadingState(true));
    final response = await technicianRepository.deleteTechnician(event.id);
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

  emsBookingAccept(EmsBookingAcceptEvent event, Emitter<TechnicianState> emit) async {
    emit(LoadingState(true));
    final response = await technicianRepository.emsBookingAccept(
      technicianAcceptRejectRequest: event.technicianAcceptRejectRequest,
    );
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<TechnicianAcceptRejectResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  emsBookingReject(EmsBookingRejectEvent event, Emitter<TechnicianState> emit) async {
    emit(LoadingState(true));
    final response = await technicianRepository.emsBookingReject(
      technicianAcceptRejectRequest: event.technicianAcceptRejectRequest,
    );
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<TechnicianAcceptRejectResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  getRideHistory(GetRideHistoryEvent event, Emitter<TechnicianState> emit) async {
    emit(LoadingState(true));
    final response = await technicianRepository.getRideHistory(event.id);
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
