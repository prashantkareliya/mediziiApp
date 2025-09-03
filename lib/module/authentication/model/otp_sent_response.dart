class SendOtpResponse {
  bool? error;
  String? message;

  SendOtpResponse({this.error, this.message});

  SendOtpResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}
