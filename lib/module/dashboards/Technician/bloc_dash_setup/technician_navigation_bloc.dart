import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medizii/module/dashboards/Technician/bloc_dash_setup/technician_navigation_state.dart';

part 'technician_navigation_event.dart';


class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(selectedIndex: 0)) {
    on<NavigationTabChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}