import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  List<Order> orders;

  OrderDetailsModel({
    this.orders,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => new OrderDetailsModel(
    orders: new List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orders": new List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  String uname;
  String menu;
  String userid;
  String orderedby;
  String messageType;

  Order({
    this.uname,
    this.menu,
    this.userid,
    this.orderedby,
    this.messageType,
  });

  factory Order.fromJson(Map<String, dynamic> json) => new Order(
    uname: json["uname"],
    menu: json["menu"],
    userid: json["userid"],
    orderedby: json["orderedby"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "uname": uname,
    "menu": menu,
    "userid": userid,
    "orderedby": orderedby,
    "messageType": messageType,
  };
}
