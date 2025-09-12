part of 'patient_bloc.dart';

@immutable
sealed class PatientEvent {}


class GetAllDoctorEvent extends PatientEvent {
  GetAllDoctorEvent();
}

class GetPatientByIdEvent extends PatientEvent {
  String id;
  GetPatientByIdEvent(this.id);
}

class DeletePatientEvent extends PatientEvent {
  String id;
  DeletePatientEvent(this.id);
}

class UploadReportImagesEvent extends PatientEvent {
  UploadReportRequest uploadReportRequest;
  final String id;

  UploadReportImagesEvent(this.id, this.uploadReportRequest);
}

//EmsBookingEvent
class EmsBookingEvent extends PatientEvent {
  final EmsBookingRequest emsBookingRequest;
  EmsBookingEvent(this.emsBookingRequest);
}

class BookingDetailEvent extends PatientEvent {
  GetBookingDetailRequest getBookingDetailRequest;

  BookingDetailEvent(this.getBookingDetailRequest);
}