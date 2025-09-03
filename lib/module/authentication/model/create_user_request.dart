class CreateUserRequest {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? role;
  String? hospital;
  String? occupation;
  int? experience;
  int? age;
  String? sex;
  String? type;
  String? otp;
  String? blood;

  CreateUserRequest(
      {this.name,
        this.email,
        this.phone,
        this.password,
        this.role,
        this.hospital,
        this.occupation,
        this.experience,
        this.age,
        this.sex,
        this.type,
        this.otp,
      this.blood});

  CreateUserRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    hospital = json['hospital'];
    occupation = json['occupation'];
    experience = json['experience'];
    age = json['age'];
    sex = json['sex'];
    type = json['type'];
    otp = json['otp'];
    blood = json['blood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['role'] = role;
    data['hospital'] = hospital;
    data['occupation'] = occupation;
    data['experience'] = experience;
    data['age'] = age;
    data['sex'] = sex;
    data['type'] = type;
    data['otp'] = otp;
    data['blood'] = blood;
    return data;
  }
}
