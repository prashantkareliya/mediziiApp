class GetRecentPatientResponse {
  bool? success;
  String? message;
  List<Patients>? patients;

  GetRecentPatientResponse({this.success, this.message, this.patients});

  GetRecentPatientResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients!.add(new Patients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (patients != null) {
      data['patients'] = patients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patients {
  Location? location;
  CurrentBooking? currentBooking;
  String? deviceType;
  String? sId;
  String? name;
  String? sex;
  String? password;
  int? age;
  String? blood;
  String? phone;
  String? email;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? deviceToken;
  String? socketId;

  Patients({
    this.location,
    this.currentBooking,
    this.deviceType,
    this.sId,
    this.name,
    this.sex,
    this.password,
    this.age,
    this.blood,
    this.phone,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.deviceToken,
    this.socketId,
  });

  Patients.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    currentBooking = json['currentBooking'] != null ? new CurrentBooking.fromJson(json['currentBooking']) : null;
    deviceType = json['device_type'];

    sId = json['_id'];
    name = json['name'];
    sex = json['sex'];
    password = json['password'];
    age = json['age'];
    blood = json['blood'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    deviceToken = json['device_token'];
    socketId = json['socketId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (currentBooking != null) {
      data['currentBooking'] = currentBooking!.toJson();
    }
    data['device_type'] = deviceType;

    data['_id'] = sId;
    data['name'] = name;
    data['sex'] = sex;
    data['password'] = password;
    data['age'] = age;
    data['blood'] = blood;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['device_token'] = deviceToken;
    data['socketId'] = socketId;
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
