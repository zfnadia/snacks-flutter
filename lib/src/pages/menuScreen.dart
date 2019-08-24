import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    _menuBloc = BlocProvider.of(context);
    _menuBloc.showMenu();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
        ),
//            image: DecorationImage(
//                image: AssetImage(
//                  "",
//                ),
//                fit: BoxFit.fill)),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Today's Menu",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: _menuBloc.mainMenu,
                builder: (context, snapshot) {
                  return menuItem(snapshot, foodImage);
                },
              ),
//              mainMenuItem(),
              SizedBox(
                height: 20,
              ),
              Text(
                "Alternate Menu",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
//                  color: Colors.deepOrange,
                  child: Column(
                    children: <Widget>[
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
}
