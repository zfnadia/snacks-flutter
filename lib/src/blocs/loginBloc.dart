import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/blocs/validators/validators.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/routes/routes.dart';
import 'package:snacks_app/src/sessionManager/sessionManager.dart';
import 'package:connectivity/connectivity.dart';

class LoginBloc extends BlocBase with Validators {
  //-------------------BehaviorSubjects-----------------------------------------
  final _emailAddress = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _connectionStatus = BehaviorSubject<bool>();

  //-----------------------Stream-----------------------------------------------
  Stream<String> get emailAddress =>
      _emailAddress.stream.transform(validateEmailAddress);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get loginDataValid =>
      Observable.combineLatest2(emailAddress, password, (e, p) => true);

  Stream<bool> get connectionStatus => _connectionStatus.stream;

  //-----------------------Function---------------------------------------------
  Function(String) get sinkEmail => _emailAddress.sink.add;

  Function(String) get sinkPassword => _password.sink.add;

  Function(bool) get sinkConnectionStatus => _connectionStatus.sink.add;

  @override
  void dispose() {
    _emailAddress.close();
    _password.close();
    _connectionStatus.close();
  }

//  void clearAllData() {
//    _emailAddress.value = null;
//    _password.value = null;
//  }

  submitLoginData(BuildContext context) async {
    final emailAddress = _emailAddress.value;
    final password = _password.value;

    print('email: $emailAddress \n password: $password');

    api.getLoginData(emailAddress, password).then((onValue) async {
      if (onValue.login[0].email != null) {
        print("Response from server: $onValue");
        sessionManager.createSession(onValue.login[0]).whenComplete(() {
          print("I am here");
          routes.goToHomePage(context);
        });
      } else {
        print("Post not executed");
      }
    });
  }

  void checkLoginStatus(BuildContext context) async {
    var isLoggedIn = await sessionManager.isLoggedIn;
    if (isLoggedIn) {
      routes.goToHomePage(context);
    } else {
      routes.goToLoginPage(context);
    }
  }

  void checkConnectionStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      sinkConnectionStatus(false);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          sinkConnectionStatus(true);
        }
      } on SocketException catch (_) {
        print('not connected');
        sinkConnectionStatus(false);
      }
      sinkConnectionStatus(true);
    }
  }
}
