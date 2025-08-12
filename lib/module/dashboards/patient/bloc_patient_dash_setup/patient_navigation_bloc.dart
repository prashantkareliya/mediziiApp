import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medizii/module/dashboards/patient/bloc_patient_dash_setup/patient_navigation_state.dart';

part 'patient_navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(selectedIndex: 0)) {
    on<NavigationTabChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}
