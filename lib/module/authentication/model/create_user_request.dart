class CreateUserRequest {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? role;
  String? otp;

  CreateUserRequest({this.name, this.email, this.password, this.phone, this.role, this.otp});

  CreateUserRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['otp'] = this.otp;
    return data;
  }
}
