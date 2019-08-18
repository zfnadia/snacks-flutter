import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  String messageType;
  String mainMenu;
  String alternateMenu;

  MenuModel({
    this.messageType,
    this.mainMenu,
    this.alternateMenu,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => new MenuModel(
    messageType: json["messageType"],
    mainMenu: json["mainMenu"],
    alternateMenu: json["AlternateMenu"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "mainMenu": mainMenu,
    "AlternateMenu": alternateMenu,
  };
}
