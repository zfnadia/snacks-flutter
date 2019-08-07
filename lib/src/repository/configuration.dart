import 'dart:io';

import 'package:dio/dio.dart';

class NetworkConfiguration {
  static const String BASE_URL = "http://172.16.9.235";
  static const String LOGIN_URL = "/snacks/SnacksLogin.asp";

  //http://172.16.9.235/snacks/SnacksLogin.asp

  //--------------------------------------------------------------------------//

  static const int CONNECTION_TIMEOUT = 5000;
  static const int RECEIVE_TIMEOUT = 30000;

  //-------------------------------------------------------------------------//

  static final baseOptions = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: CONNECTION_TIMEOUT,
    receiveTimeout: RECEIVE_TIMEOUT,
  );
}
