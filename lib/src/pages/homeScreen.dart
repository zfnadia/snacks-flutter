import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/bottomNavigationBloc.dart';
import 'package:snacks_app/src/blocs/colleagueOrderBloc.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/myOrderBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

import 'colleagueOrderScreen.dart';
import 'menuScreen.dart';
import 'myOrderScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    MenuScreen(),
    MyOrder(),
    ColleagueOrder(),
  ];

  final List<String> _pageNames = [
    "Welcome",
    "My Order",
    "Order for a Colleague!"
  ];

  BottomNavigationBloc bottomNavigationBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomNavigationBloc = BlocProvider.of(context);
    bottomNavigationBloc.getPageNames();
  }

  @override
  void dispose() {
//    bottomNavigationBloc.clearAllData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      bloc: MenuBloc(),
      child: BlocProvider(
        bloc: MyOrderBloc(),
        child: BlocProvider(
          bloc: ColleagueOrderBloc(),
          child: bottomBar(),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget bottomBar() {
    return StreamBuilder(
        stream: bottomNavigationBloc.pageIndex,
        initialData: 0,
        builder: (context, snapshot) {
          int _currentIndex =
          snapshot.hasData && snapshot.data is int ? snapshot.data : 0;

          return StreamBuilder(
            stream: bottomNavigationBloc.pageNames,
            initialData: _pageNames,
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.deepPurple,
                  title: Text(
                    snapshot.hasData && snapshot.data is List<Widget>
                        ? snapshot.data[_currentIndex]
                        : _pageNames[_currentIndex],
                  ),
                ),
//                bottomNavigationBar: FancyBottomNavigation(
//                  circleColor: Colors.deepPurple,
//                  activeIconColor: Colors.white,
//                  tabs: [
//                    TabData(iconData: Icons.fastfood, title: "Menu"),
//                    TabData(iconData: Icons.favorite, title: "My Order"),
//                    TabData(iconData: Icons.supervisor_account, title:"Colleague's Order"),
//                  ],
////                  onTabChangedListener: (position) {
////                    setState(() {
////                      _currentIndex = position;
////                    });
////                  },
//                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: bottomNavigationBloc.changedPageIndex,
                  currentIndex: _currentIndex,
                  fixedColor: Colors.deepPurple,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.fastfood),
                      title: Text("Menu"),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      title: Text("My Order"),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.supervisor_account),
                      title: Text("Colleague's Order"),
                    ),
                  ],
                ),
                body: _widgetOptions[_currentIndex],
              );
            },
          );
        });
  }
}
