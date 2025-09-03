import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'technician_event.dart';
part 'technician_state.dart';

class TechnicianBloc extends Bloc<TechnicianEvent, TechnicianState> {
  TechnicianBloc() : super(TechnicianInitial()) {
    on<TechnicianEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
