import 'package:dio/dio.dart';

class NetworkConfiguration {
  static const String BASE_URL = "http://172.16.9.235";
  static const String LOGIN_URL = "/snacks/SnacksLogin.asp";
  static const String MENU_URL = "/snacks/getmenu.asp";
  static const String ORDER_URL = "/snacks/ordersnacks.asp";
  static const String USER_LIST_URL = "/snacks/getuserlist.asp";
  static const String VIEW_TODAY_ORDER_URL = "/snacks/viewtodayorder.asp";

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
