class GetRideHistoryResponse {
  bool? error;
  String? message;
  Technician? technician;

  GetRideHistoryResponse({this.error, this.message, this.technician});

  GetRideHistoryResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    technician = json['technician'] != null
        ? new Technician.fromJson(json['technician'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (technician != null) {
      data['technician'] = technician!.toJson();
    }
    return data;
  }
}

class Technician {
  String? sId;
  String? name;
  String? status;
  String? phone;
  List<RideHistory>? rideHistory;

  Technician({this.sId, this.name, this.status, this.phone, this.rideHistory});

  Technician.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    phone = json['phone'];
    if (json['rideHistory'] != null) {
      rideHistory = <RideHistory>[];
      json['rideHistory'].forEach((v) {
        rideHistory!.add(new RideHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['status'] = status;
    data['phone'] = phone;
    if (rideHistory != null) {
      data['rideHistory'] = rideHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RideHistory {
  String? sId;
  String? patientId;
  String? status;
  PatientLocation? patientLocation;
  PatientLocation? destinationLocation;
  String? requestedAt;
  int? fare;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? acceptedAt;
  String? technicianId;
  String? hospitalId;
  String? pickedUpAt;
  String? completedAt;

  RideHistory(
      {this.sId,
        this.patientId,
        this.status,
        this.patientLocation,
        this.destinationLocation,
        this.requestedAt,
        this.fare,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.acceptedAt,
        this.technicianId,
        this.hospitalId,
        this.pickedUpAt,
        this.completedAt});

  RideHistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patientId = json['patientId'];
    status = json['status'];
    patientLocation = json['patientLocation'] != null
        ? new PatientLocation.fromJson(json['patientLocation'])
        : null;
    destinationLocation = json['destinationLocation'] != null
        ? new PatientLocation.fromJson(json['destinationLocation'])
        : null;
    requestedAt = json['requestedAt'];
    fare = json['fare'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    acceptedAt = json['acceptedAt'];
    technicianId = json['technicianId'];
    hospitalId = json['hospitalId'];
    pickedUpAt = json['pickedUpAt'];
    completedAt = json['completedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['patientId'] = patientId;
    data['status'] = status;
    if (patientLocation != null) {
      data['patientLocation'] = patientLocation!.toJson();
    }
    if (destinationLocation != null) {
      data['destinationLocation'] = destinationLocation!.toJson();
    }
    data['requestedAt'] = requestedAt;
    data['fare'] = fare;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['acceptedAt'] = acceptedAt;
    data['technicianId'] = technicianId;
    data['hospitalId'] = hospitalId;
    data['pickedUpAt'] = pickedUpAt;
    data['completedAt'] = completedAt;
    return data;
  }
}

class PatientLocation {
  String? type;
  List<double>? coordinates;

  PatientLocation({this.type, this.coordinates});

  PatientLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
