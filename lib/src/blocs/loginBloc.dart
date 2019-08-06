import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/blocs/validators/validators.dart';

class LoginBloc extends BlocBase with Validators {

  //-------------------BehaviorSubjects-----------------------------------------
  final _emailAddress = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //-----------------------Stream-----------------------------------------------
  Stream<String> get emailAddress => _emailAddress.stream.transform(validateEmailAddress);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get loginDataValid =>
      Observable.combineLatest2(emailAddress, password, (e, p) => true);

  //-----------------------Function---------------------------------------------
  Function(String) get sinkEmail => _emailAddress.sink.add;
  Function(String) get sinkPassword => _password.sink.add;

  @override
  void dispose() {
    _emailAddress.close();
    _password.close();
  }

//  void clearAllData() {
//    _emailAddress.value = null;
//    _password.value = null;
//  }

  submitLoginData(BuildContext context) {
    final emailAddress = _emailAddress.value;
    final password = _password.value;

    print('email: $emailAddress \n password: $password');
  }
}
