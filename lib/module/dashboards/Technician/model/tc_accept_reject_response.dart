class TechnicianAcceptRejectResponse {
  bool? success;
  String? message;
  Booking? booking;

  TechnicianAcceptRejectResponse({this.success, this.message, this.booking});

  TechnicianAcceptRejectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    booking = json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    return data;
  }
}

class Booking {
  String? sId;
  PatientId? patientId;
  String? status;
  PatientLocation? patientLocation;
  PatientLocation? destinationLocation;
  String? requestedAt;
  int? fare;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? acceptedAt;
  TechnicianId? technicianId;
  HospitalId? hospitalId;

  Booking({
    this.sId,
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
  });

  Booking.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patientId = json['patientId'] != null ? new PatientId.fromJson(json['patientId']) : null;
    status = json['status'];
    patientLocation = json['patientLocation'] != null ? new PatientLocation.fromJson(json['patientLocation']) : null;
    destinationLocation = json['destinationLocation'] != null ? new PatientLocation.fromJson(json['destinationLocation']) : null;
    requestedAt = json['requestedAt'];
    fare = json['fare'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    acceptedAt = json['acceptedAt'];
    technicianId = json['technicianId'] != null ? new TechnicianId.fromJson(json['technicianId']) : null;
    hospitalId = json['hospitalId'] != null ? new HospitalId.fromJson(json['hospitalId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (patientId != null) {
      data['patientId'] = patientId!.toJson();
    }
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
    if (technicianId != null) {
      data['technicianId'] = technicianId!.toJson();
    }
    if (hospitalId != null) {
      data['hospitalId'] = hospitalId!.toJson();
    }
    return data;
  }
}

class PatientId {
  String? sId;
  String? name;
  String? sex;
  String? password;
  int? age;
  String? blood;
  String? phone;
  String? email;
  PatientLocation? location;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PatientId({
    this.sId,
    this.name,
    this.sex,
    this.password,
    this.age,
    this.blood,
    this.phone,
    this.email,
    this.location,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  PatientId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    sex = json['sex'];
    password = json['password'];
    age = json['age'];
    blood = json['blood'];
    phone = json['phone'];
    email = json['email'];
    location = json['location'] != null ? new PatientLocation.fromJson(json['location']) : null;
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['sex'] = sex;
    data['password'] = password;
    data['age'] = age;
    data['blood'] = blood;
    data['phone'] = phone;
    data['email'] = email;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Location {
  String? type;
  List<int>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
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

class TechnicianId {
  String? sId;
  String? name;
  int? age;
  String? password;
  int? experience;
  String? status;
  String? phone;
  String? email;
  String? role;
  PatientLocation? location;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? socketId;
  String? fcmToken;
  CurrentBooking? currentBooking;

  TechnicianId({
    this.sId,
    this.name,
    this.age,
    this.password,
    this.experience,
    this.status,
    this.phone,
    this.email,
    this.role,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.socketId,
    this.fcmToken,
    this.currentBooking,
  });

  TechnicianId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    password = json['password'];
    experience = json['experience'];
    status = json['status'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    location = json['location'] != null ? new PatientLocation.fromJson(json['location']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    socketId = json['socketId'];
    fcmToken = json['fcmToken'];
    currentBooking = json['currentBooking'] != null ? new CurrentBooking.fromJson(json['currentBooking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['age'] = age;
    data['password'] = password;
    data['experience'] = experience;
    data['status'] = status;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['socketId'] = socketId;
    data['fcmToken'] = fcmToken;
    if (currentBooking != null) {
      data['currentBooking'] = currentBooking!.toJson();
    }
    return data;
  }
}

class CurrentBooking {
  String? status;

  CurrentBooking({this.status});

  CurrentBooking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class HospitalId {
  String? sId;
  String? name;
  String? type;
  String? address;
  PatientLocation? location;
  int? iV;
  String? createdAt;
  String? updatedAt;

  HospitalId({this.sId, this.name, this.type, this.address, this.location, this.iV, this.createdAt, this.updatedAt});

  HospitalId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    address = json['address'];
    location = json['location'] != null ? new PatientLocation.fromJson(json['location']) : null;
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['type'] = type;
    data['address'] = address;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
