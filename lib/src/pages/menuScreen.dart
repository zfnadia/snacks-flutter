import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/loginBloc.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

final foodImage = 'assets/spag.png';
final cookies = "assets/cookie.png";
final charm = "assets/potatoes.png";
final chips = "assets/chips.png";
final double circleRadius = 70.0;
final double circleBorderWidth = 5.0;

class MenuScreen extends StatelessWidget {
  BuildContext context;
  MenuBloc _menuBloc;
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _menuBloc = BlocProvider.of(context);
    _loginBloc = BlocProvider.of(context);
    _loginBloc.sinkConnectionStatus(false);
    _loginBloc.checkConnectionStatus();
    _menuBloc.showMenu();

    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "Today's Menu",
              style: TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: _menuBloc.mainMenu,
              builder: (context, snapshot) {
                return menuItem(snapshot, foodImage);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text("Alternate Menu",
                style: TextStyle(fontSize: 25.0), textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: _menuBloc.altMenuOne,
              builder: (context, snapshot) {
                return menuItem(snapshot, cookies);
              },
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: _menuBloc.altMenuTwo,
              builder: (context, snapshot) {
                return menuItem(snapshot, charm);
              },
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: _menuBloc.altMenuThree,
              builder: (context, snapshot) {
                return menuItem(snapshot, chips);
              },
            ),
            SizedBox(
              height: 100,
            ),
          ],
        )
      ],
    ));
  }

  Widget menuItem(snapshot, foodImage) {
    return Container(
      height: 100.0,
      width: double.infinity,
      //color: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 40.0),
              child: Card(
                  elevation: 4.0,
                  //replace this Container with your Card
                  color: Colors.white,
                  child: Center(
                    child: Text(
                        snapshot.hasData && snapshot.data is String
                            ? snapshot.data.toString()
                            : "",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
//                  },
                  )),
            ),
            Positioned(
              top: 5,
              child: Container(
                width: circleRadius,
                height: circleRadius,
                decoration:
                    ShapeDecoration(shape: CircleBorder(), color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(circleBorderWidth),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: AssetImage(foodImage))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//
//  static Widget internetStatus(snapshot) {
//    if (snapshot.data == null) {
//      return Text('');
//    } else if (snapshot.data == false) {
//      return Text("No Internet Connection!");
//    }
//    return Text('');
//  }
}
