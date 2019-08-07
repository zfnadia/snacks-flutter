import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  List<Login> login;

  LoginModel({
    this.login,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => new LoginModel(
        login:
            new List<Login>.from(json["login"].map((x) => Login.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "login": new List<dynamic>.from(login.map((x) => x.toJson())),
      };
}

class Login {
  String userName;
  String gid;
  String email;
  String messageType;

  Login({
    this.userName,
    this.gid,
    this.email,
    this.messageType,
  });

  factory Login.fromJson(Map<String, dynamic> json) => new Login(
        userName: json["user_name"],
        gid: json["gid"],
        email: json["Email"],
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "gid": gid,
        "Email": email,
        "messageType": messageType,
      };
}
