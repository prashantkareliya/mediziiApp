class GetBookingDetailRequest {
  String? bookingId;

  GetBookingDetailRequest({this.bookingId});

  GetBookingDetailRequest.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    return data;
  }
}
