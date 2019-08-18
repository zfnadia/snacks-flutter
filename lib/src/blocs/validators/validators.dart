import 'dart:async';

import 'package:snacks_app/src/repository/modelClasses/menuModel.dart';

class Validators {
  final validateEmailAddress =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    bool validEmail =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (validEmail)
      sink.add(email);
    else
      sink.addError("Email is not valid");
//      sink.add("Email is not valid");
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 4 && password.length <= 8) {
      sink.add(password);
    } else {
      sink.addError(
          "Password can not be less than 4 charecter or more than 8 charecter");
//      sink.add("Email is not valid");
    }
  });

  final validateMenu =
  StreamTransformer<MenuModel, MenuModel>.fromHandlers(handleData: (menu, sink) {
    if (menu != null) {
      sink.add(menu);
    } else {
      sink.addError('Menu not found');
//      print("Menu not found");
    }
  });

//  final validateUserName = StreamTransformer<String, String>.fromHandlers(
//      handleData: (userName, sink) {
//    if (userName.length > 3) {
//      sink.add(userName);
//    } else {
//      sink.addError("Username can not be less than 4 characters");
//    }
//  });
}
