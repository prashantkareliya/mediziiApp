class LoginResponse {
  bool? error;
  String? message;
  Data? data;
  String? token;

  LoginResponse({this.error, this.message, this.data, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  Location? location;
  CurrentBooking? currentBooking;
  String? deviceType;
  String? sId;
  String? name;
  String? sex;
  int? age;
  String? blood;
  String? phone;
  String? email;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? deviceToken;

  Data(
      {this.location,
        this.currentBooking,
        this.deviceType,
        this.sId,
        this.name,
        this.sex,
        this.age,
        this.blood,
        this.phone,
        this.email,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.deviceToken});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    currentBooking = json['currentBooking'] != null
        ? new CurrentBooking.fromJson(json['currentBooking'])
        : null;
    deviceType = json['device_type'];

    sId = json['_id'];
    name = json['name'];
    sex = json['sex'];
    age = json['age'];
    blood = json['blood'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    deviceToken = json['device_token'];
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
    data['age'] = age;
    data['blood'] = blood;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['device_token'] = deviceToken;
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