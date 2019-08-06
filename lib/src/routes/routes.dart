import 'package:flutter/material.dart';
import 'package:snacks_app/src/pages/homeScreen.dart';
import 'package:snacks_app/src/pages/loginScreen.dart';

class Routes {
  void goToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}

final routes = Routes();
