class LoginRequest {
  String? phone;
  String? password;
  String? deviceToken;
  String? deviceType;

  LoginRequest({this.phone, this.password, this.deviceToken, this.deviceType});

  Map<String, dynamic> toJson() {
    return {'phone': phone, 'password': password, 'device_token': deviceToken, 'device_type': deviceType};
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      phone: json['phone'],
      password: json['password'],
      deviceToken: json['device_token'],
      deviceType: json['device_type'],
    );
  }
}
