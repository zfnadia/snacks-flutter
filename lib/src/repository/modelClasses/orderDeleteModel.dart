import 'dart:convert';

OrderDeleteModel orderDeleteModelFromJson(String str) => OrderDeleteModel.fromJson(json.decode(str));

String orderDeleteModelToJson(OrderDeleteModel data) => json.encode(data.toJson());

class OrderDeleteModel {
  String messageType;

  OrderDeleteModel({
    this.messageType,
  });

  factory OrderDeleteModel.fromJson(Map<String, dynamic> json) => new OrderDeleteModel(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
