import 'package:bloc/bloc.dart';
import 'package:medizii/module/dashboards/doctor/model/delete_doctor_response.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/get_all_doctor_response.dart';
import 'package:meta/meta.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final PatientRepository patientRepository;

  PatientBloc(this.patientRepository) : super(PatientInitial()) {
    on<PatientEvent>((event, emit) {});
    on<GetAllDoctorEvent>((event, emit) => _getAllDoctor(event, emit));

    on<DeletePatientEvent>((event, emit) => _deletePatient(event, emit));


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
}
