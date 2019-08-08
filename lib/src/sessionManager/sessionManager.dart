import 'dart:async';
import 'package:snacks_app/src/repository/modelClasses/loginModel.dart';
import 'preferencesHelper.dart';

class SessionManager {
  Future<void> createSession(Login userData) async {
    await Future.wait(<Future>[
      setIsLoggedIn(true),
    ]);
  }

  Future<bool> get isLoggedIn =>
      PreferenceHelper.getBool("isloggedin");

  Future setIsLoggedIn(bool value) =>
      PreferenceHelper.setBool("isloggedin", value);

  Future<void> clearSession() async {
    await Future.wait(<Future>[
      setIsLoggedIn(false),
    ]);
  }
}

final sessionManager = SessionManager();
