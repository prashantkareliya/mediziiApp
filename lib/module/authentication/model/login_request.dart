class LoginRequest {
  String? phone;
  String? password;

  LoginRequest({
    this.phone,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      phone: json['phone'],
      password: json['password'],

    );
  }
}
