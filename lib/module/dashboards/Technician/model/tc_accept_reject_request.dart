class TechnicianAcceptRejectRequest {
  String? technicianId;
  String? bookingId;

  TechnicianAcceptRejectRequest({this.technicianId, this.bookingId});

  TechnicianAcceptRejectRequest.fromJson(Map<String, dynamic> json) {
    technicianId = json['technicianId'];
    bookingId = json['bookingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['technicianId'] = technicianId;
    data['bookingId'] = bookingId;
    return data;
  }
}
