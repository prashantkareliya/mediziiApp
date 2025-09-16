part of 'technician_bloc.dart';

@immutable
sealed class TechnicianEvent {}

class GetTechnicianByIdEvent extends TechnicianEvent {
  String id;

  GetTechnicianByIdEvent(this.id);
}

class DeleteTechnicianEvent extends TechnicianEvent {
  String id;

  DeleteTechnicianEvent(this.id);
}

class EmsBookingAcceptEvent extends TechnicianEvent {
  final TechnicianAcceptRejectRequest technicianAcceptRejectRequest;
  EmsBookingAcceptEvent(this.technicianAcceptRejectRequest);
}

class EmsBookingRejectEvent extends TechnicianEvent {
  final TechnicianAcceptRejectRequest technicianAcceptRejectRequest;
  EmsBookingRejectEvent(this.technicianAcceptRejectRequest);
}

class GetRideHistoryEvent extends TechnicianEvent {
  String id;

  GetRideHistoryEvent(this.id);
}