import 'dart:async';
import 'package:snacks_app/src/repository/modelClasses/loginModel.dart';
import 'package:snacks_app/src/routes/routes.dart';
import 'preferencesHelper.dart';

class SessionManager {
  Future<void> createSession(Login userData) async {
    await Future.wait(<Future>[
      setIsLoggedIn(true),
      setUserName(userData.userName),
      setUserID(userData.gid),
    ]);
  }

  Future<bool> get isLoggedIn => PreferenceHelper.getBool("isloggedin");

  Future setIsLoggedIn(bool value) =>
      PreferenceHelper.setBool("isloggedin", value);

  Future<String> get userName => PreferenceHelper.getString("user_name");

  Future setUserName(String value) =>
      PreferenceHelper.setString("user_name", value);

  Future<String> get userID => PreferenceHelper.getString("gid");

  Future<String> setUserID(String value) =>
      PreferenceHelper.setString("gid", value);

  Future<void> clearSession() async {
    await Future.wait(
        <Future>[setIsLoggedIn(false), setUserName(""), setUserID("")]);
  }

  void signOut(context) {
    sessionManager.clearSession().whenComplete(() {
      routes.goToLoginPage(context);
    });
  }
}

final sessionManager = SessionManager();
