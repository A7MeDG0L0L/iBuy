class RegisterModel {
  String name;
  String phone;
  String email;
  String password;
  String uId;

  RegisterModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.password,
  });
  RegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    password = json['password'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'password': password,
    };
  }
}
