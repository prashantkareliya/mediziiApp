part of 'technician_navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class NavigationTabChanged extends NavigationEvent {
  final int index;
  NavigationTabChanged(this.index);
}
