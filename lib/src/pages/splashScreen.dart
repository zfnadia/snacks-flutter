import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/loginBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

class SplashScreen extends StatelessWidget {
  final Color gradientStart =
      Colors.deepPurple[700]; //Change start gradient color here
  final Color gradientEnd = Colors.purple[500];
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of(context);
    _loginBloc.checkLoginStatus(context);
    return Scaffold(
        body: Center(
            child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red])),
      child: Center(
        child: Container(
          height: 120.0,
          width: 120.0,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            image: DecorationImage(
              image: new AssetImage('assets/bdjobs_logo_img.png'),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.rectangle,
          ),
        ),
      ),
    )));
  }
}
