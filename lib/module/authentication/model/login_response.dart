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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  Location? location;
  String? sId;
  String? name;
  int? age;
  String? type;
  String? hospital;
  String? occupation;
  int? experience;
  String? phone;
  String? email;
  String? role;
  String? sex;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.location,
        this.sId,
        this.name,
        this.age,
        this.type,
        this.hospital,
        this.occupation,
        this.experience,
        this.phone,
        this.email,
        this.role,
        this.sex,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    type = json['type'];
    hospital = json['hospital'];
    occupation = json['occupation'];
    experience = json['experience'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    sex = json['sex'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['type'] = this.type;
    data['hospital'] = this.hospital;
    data['occupation'] = this.occupation;
    data['experience'] = this.experience;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['role'] = this.role;
    data['sex'] = this.sex;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
