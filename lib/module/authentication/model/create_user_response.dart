class CreateUserResponse {
  bool? error;
  String? message;
  Data? data;
  String? token;

  CreateUserResponse({this.error, this.message, this.data, this.token});

  CreateUserResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? name;
  int? age;
  String? type;
  String? hospital;
  String? occupation;
  int? experience;
  String? phone;
  String? email;
  Location? location;
  String? role;
  String? sex;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.name,
        this.age,
        this.type,
        this.hospital,
        this.occupation,
        this.experience,
        this.phone,
        this.email,
        this.location,
        this.role,
        this.sex,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    type = json['type'];
    hospital = json['hospital'];
    occupation = json['occupation'];
    experience = json['experience'];
    phone = json['phone'];
    email = json['email'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    role = json['role'];
    sex = json['sex'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['age'] = age;
    data['type'] = type;
    data['hospital'] = hospital;
    data['occupation'] = occupation;
    data['experience'] = experience;
    data['phone'] = phone;
    data['email'] = email;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['role'] = role;
    data['sex'] = sex;
    data['_id'] = sId;
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
