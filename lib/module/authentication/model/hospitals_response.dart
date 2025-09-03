class HospitalResponse {
  bool? error;
  int? count;
  List<HospitalData>? data;

  HospitalResponse({this.error, this.count, this.data});

  HospitalResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    count = json['count'];
    if (json['data'] != null) {
      data = <HospitalData>[];
      json['data'].forEach((v) {
        data!.add(new HospitalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HospitalData {
  Location? location;
  String? sId;
  String? name;
  String? type;
  String? address;
  int? iV;
  String? createdAt;
  String? updatedAt;

  HospitalData(
      {this.location,
        this.sId,
        this.name,
        this.type,
        this.address,
        this.iV,
        this.createdAt,
        this.updatedAt});

  HospitalData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    address = json['address'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['address'] = this.address;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
