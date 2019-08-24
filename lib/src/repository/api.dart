import 'dart:io';
import 'package:snacks_app/src/repository/modelClasses/loginModel.dart';
import 'package:dio/dio.dart';
import 'configuration.dart';
import 'modelClasses/menuModel.dart';
import 'modelClasses/orderModel.dart';
import 'modelClasses/userListModel.dart';

class ApiProvider {
  final _dio = Dio(NetworkConfiguration.baseOptions);

  Future<LoginModel> getLoginData(String username, String password) async {
    var response = await _dio.post(
      NetworkConfiguration.LOGIN_URL,
      data: {"un": username, "up": password},
      options: Options(
          method: 'POST',
          contentType: ContentType.parse('application/x-www-form-urlencoded'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
          }),
    );
    print(response.data);
    return LoginModel.fromJson(response.data);
  }

  Future<MenuModel> getMenu() async {
    print("I'm in FUTURE");
    var response = await _dio.request(NetworkConfiguration.MENU_URL,
        options: Options(method: "GET"));
    print("${response.data} FURRRRRRR");
    return MenuModel.fromJson(response.data);
  }

  Future<UserListModel> getUserList() async {
    var response = await _dio.request(NetworkConfiguration.USER_LIST_URL,
        options: Options(method: "GET"));
    print(response.data);
    return UserListModel.fromJson(response.data);
  }

  Future<OrderModel> sendOrder(
      String userId, String userName, String order, String clgOrder) async {
    var response = await _dio.get(
      NetworkConfiguration.ORDER_URL,
      /*When sending values through parameters in a GET request,
       use queryParameters: {} instead of data: {} */
      queryParameters: {
        "userid": userId,
        "uname": userName,
        "menu": order,
        "corder": clgOrder
      },
      options: Options(
          method: "GET",
          contentType: ContentType.parse('application/x-www-form-urlencoded'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
          }),
    );
    print(
        "UserID $userId Name $userName Menu $order OtherId $clgOrder MESSAGE TYPE $response");
    return OrderModel.fromJson(response.data);
  }

  Future<OrderModel> getOrderStatus(String userId) async {
    var response = await _dio.request(NetworkConfiguration.VIEW_TODAY_ORDER_URL,
        options: Options(method: "GET"),
        queryParameters: {
          "userid": userId,
        });
    OrderModel orderModel = OrderModel.fromJson(response.data);
    return orderModel;
  }
}

final api = ApiProvider();
