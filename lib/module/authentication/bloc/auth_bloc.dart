import 'package:bloc/bloc.dart';
import 'package:medizii/module/authentication/data/repository.dart';
import 'package:medizii/module/authentication/model/create_user_response.dart';
import 'package:medizii/module/authentication/model/forget_password_response.dart';
import 'package:medizii/module/authentication/model/hospitals_response.dart';
import 'package:medizii/module/authentication/model/login_response.dart';
import 'package:medizii/module/authentication/model/nearest_hospital_response.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<CreateUserEvent>((event, emit) => _createUser(event, emit));
    on<LoginUserEvent>((event, emit) => _loginUser(event, emit));
    on<SendOtpEvent>((event, emit) => _sendOtp(event, emit));


    on<FetchHospitalsEvent>((event, emit) => getHospitals(event, emit));
    on<NearestHospitalEvent>((event, emit) => getNearestHospitals(event, emit));
  }


  _createUser(CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState(true));

    final response = await authRepository.createUser(
      createUserRequest: event.createUserRequest,
    );

    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<CreateUserResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  // Single login handler
  _loginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState(true));

    final response = await authRepository.loginUser(
      loginRequest: event.loginRequest,
      role: event.role,
    );

    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<LoginResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }

  _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState(true));

    final response = await authRepository.forgetPassword(
      requestData: event.forgetPasswordRequest.toJson(),
      role: event.role,
    );

    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<ForgetPasswordResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }


  getHospitals(FetchHospitalsEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState(true));
    final response = await authRepository.getHospitals();
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<HospitalResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }



  getNearestHospitals(NearestHospitalEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState(true));
    final response = await authRepository.getNearestHospital(event.lat, event.lang);
    response.when(
      success: (success) {
        emit(LoadingState(false));
        emit(LoadedState<GetNearestHospitalResponse>(data: success));
      },
      failure: (failure) {
        emit(LoadingState(false));
        emit(FailureState(failure.toString()));
      },
    );
  }
}
