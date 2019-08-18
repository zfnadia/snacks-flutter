import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/bottomNavigationBloc.dart';
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
      child: BlocProvider(
        bloc: BottomNavigationBloc(),
        child: MaterialApp(
          home: SplashScreen(),
        ),
      ),
    );
  }
}
