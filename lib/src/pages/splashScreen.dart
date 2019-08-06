import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/loginBloc.dart';

class SplashScreen extends StatelessWidget {
  final Color gradientStart =
      Colors.deepPurple[700]; //Change start gradient color here
  final Color gradientEnd = Colors.purple[500]; //Change end gradient color here

  @override
  Widget build(BuildContext context) {
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
              image: new AssetImage('assets/svgs/demo_logo.jpg'),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.rectangle,
          ),
        ),
      ),
    )));
  }
}
