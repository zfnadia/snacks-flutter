import 'dart:convert';

UserListModel userModelFromJson(String str) =>
    UserListModel.fromJson(json.decode(str));

String userModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  List<User> users;

  UserListModel({
    this.users,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      new UserListModel(
        users: new List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": new List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  String uname;
  String gid;
  String messageType;

  User({
    this.uname,
    this.gid,
    this.messageType,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        uname: json["uname"],
        gid: json["gid"],
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "uname": uname,
        "gid": gid,
        "messageType": messageType,
      };
}
