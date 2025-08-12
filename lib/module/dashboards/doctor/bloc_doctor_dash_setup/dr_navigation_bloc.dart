import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'dr_navigation_state.dart';


part 'dr_navigation_event.dart';


class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(selectedIndex: 0)) {
    on<NavigationTabChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}