import 'dart:io';

import 'package:snacks_app/src/repository/modelClasses/loginModel.dart';
import 'package:dio/dio.dart';

import 'configuration.dart';
import 'modelClasses/menuModel.dart';

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
}

final api = ApiProvider();
