class GetAllPatientResponse {
  bool? error;
  List<PatientData>? patientData;
  int? count;

  GetAllPatientResponse({this.error, this.patientData, this.count});

  GetAllPatientResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      patientData = <PatientData>[];
      json['data'].forEach((v) {
        patientData!.add(PatientData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (patientData != null) {
      data['data'] = patientData!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class PatientData {
  Location? location;
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

  PatientData(
      {this.location,
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
        this.iV});

  PatientData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
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
