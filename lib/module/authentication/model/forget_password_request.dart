class ForgetPasswordRequest {
  String? phone;
  String? otp;
  String? newPassword;

  ForgetPasswordRequest({this.phone, this.otp, this.newPassword});

  ForgetPasswordRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    otp = json['otp'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp'] = otp;
    data['newPassword'] = newPassword;
    return data;
  }
}
