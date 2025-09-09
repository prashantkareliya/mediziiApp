class GetNearestHospitalResponse {
  List<double>? userLocation;
  List<NearestHospitals>? nearestHospitals;

  GetNearestHospitalResponse({this.userLocation, this.nearestHospitals});

  GetNearestHospitalResponse.fromJson(Map<String, dynamic> json) {
    userLocation = json['userLocation'].cast<double>();
    if (json['nearestHospitals'] != null) {
      nearestHospitals = <NearestHospitals>[];
      json['nearestHospitals'].forEach((v) {
        nearestHospitals!.add(new NearestHospitals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userLocation'] = userLocation;
    if (nearestHospitals != null) {
      data['nearestHospitals'] =
          nearestHospitals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearestHospitals {
  String? name;
  String? type;
  String? address;
  Location? location;
  double? distanceInMeters;

  NearestHospitals(
      {this.name,
        this.type,
        this.address,
        this.location,
        this.distanceInMeters});

  NearestHospitals.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    address = json['address'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    distanceInMeters = json['distanceInMeters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['address'] = address;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['distanceInMeters'] = distanceInMeters;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
