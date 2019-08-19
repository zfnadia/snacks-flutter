import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/api.dart';

class MenuScreen extends StatelessWidget {
  MenuBloc _menuBloc;
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;

  @override
  Widget build(BuildContext context) {
    _menuBloc = BlocProvider.of(context);
    _menuBloc.showMenu();
    //
//    var response = api.getMenu().toString();
//    print(response + "ERRRRRRRR");
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Today's Menu",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              mainMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainMenu() {
//    return StreamBuilder(
//      stream: _menuBloc.menu,
//      builder: (context, snapshot) {
//        var name = "Main menu: ";
//        if (snapshot.hasData) {
//          name = name + snapshot.data.mainMenu + "\n \n Alternate Menu: " + snapshot.data.alternateMenu;
//          print("habijabi $name");
//        } else {
//          name = name + "STUCK IN PARADISE";
//        }
//        return Text(
//          name,
//          style: TextStyle(fontSize: 20),
//        );
//      },
//    );
    return Container(
      height: 150.0,
      width: double.infinity,
      color: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 40.0),
              child: Card(
                elevation: 4.0,
                //replace this Container with your Card
                color: Colors.blue,
                child: Center(
                    child: Text(
                  "HELLO",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            Positioned (
              top: 15,
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
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/a/a0/Bill_Gates_2018.jpg',
                            ))),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
