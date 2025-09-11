class EmsBookingRequest {
  String? patientId;
  String? lat;
  String? lng;
  String? destLat;
  String? destLng;
  String? deviceToken;
  String? deviceType;

  EmsBookingRequest({this.patientId, this.lat, this.lng, this.destLat, this.destLng, this.deviceToken, this.deviceType});

  EmsBookingRequest.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    lat = json['lat'];
    lng = json['lng'];
    destLat = json['destLat'];
    destLng = json['destLng'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientId'] = patientId;
    data['lat'] = lat;
    data['lng'] = lng;
    data['destLat'] = destLat;
    data['destLng'] = destLng;
    data['device_token'] = deviceToken;
    data['device_type'] = deviceType;
    return data;
  }
}
