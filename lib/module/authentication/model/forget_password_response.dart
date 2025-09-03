class ForgetPasswordResponse {
  String? stage;
  bool? error;
  String? message;
  int? generatedOtp;

  ForgetPasswordResponse(
      {this.stage, this.error, this.message, this.generatedOtp});

  ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    stage = json['stage'];
    error = json['error'];
    message = json['message'];
    generatedOtp = json['generatedOtp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stage'] = this.stage;
    data['error'] = this.error;
    data['message'] = this.message;
    data['generatedOtp'] = this.generatedOtp;
    return data;
  }
}
