import 'package:flutter/material.dart';
import 'package:snacks_app/src/pages/loginScreenTwo.dart';
import 'package:snacks_app/src/pages/loginScreen.dart';
import 'package:snacks_app/src/pages/splashScreen.dart';
import 'package:snacks_app/src/blocs/loginBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: LoginBloc(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
