class EmsBookingResponse {
  bool? success;
  String? message;
  String? bookingId;
  List<NearestTechnicians>? nearestTechnicians;

  EmsBookingResponse(
      {this.success, this.message, this.bookingId, this.nearestTechnicians});

  EmsBookingResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    bookingId = json['bookingId'];
    if (json['nearestTechnicians'] != null) {
      nearestTechnicians = <NearestTechnicians>[];
      json['nearestTechnicians'].forEach((v) {
        nearestTechnicians!.add(NearestTechnicians.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['bookingId'] = bookingId;
    if (nearestTechnicians != null) {
      data['nearestTechnicians'] =
          nearestTechnicians!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearestTechnicians {
  String? id;
  String? name;
  String? phone;
  Location? location;
  String? socketId;

  NearestTechnicians(
      {this.id, this.name, this.phone, this.location, this.socketId});

  NearestTechnicians.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    socketId = json['socketId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['socketId'] = socketId;
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
