import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/api.dart';


class MenuScreen extends StatelessWidget {
  MenuBloc _menuBloc;

  @override
  Widget build(BuildContext context) {
    _menuBloc = BlocProvider.of(context);
    _menuBloc.showMenu();
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
    return StreamBuilder(
      stream: _menuBloc.menu,
      builder: (context, snapshot) {
        var name = "Main menu: ";
        if (snapshot.hasData) {
          name = name + snapshot.data.mainMenu + "\n \n Alternate Menu: " + snapshot.data.alternateMenu;
          print("habijabi $name");
        } else {
          name = name + "STUCK IN PARADISE";
        }
        return Text(
          name,
          style: TextStyle(fontSize: 20),
        );
      },
    );
  }
}
