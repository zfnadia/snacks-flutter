import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/bottomNavigationBloc.dart';
import 'package:snacks_app/src/blocs/colleagueOrderBloc.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/myOrderBloc.dart';
import 'package:snacks_app/src/blocs/orderDetailsBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/modelClasses/orderDetailModel.dart';
import 'package:snacks_app/src/sessionManager/sessionManager.dart';

import 'colleagueOrderScreen.dart';
import 'menuScreen.dart';
import 'myOrderScreen.dart';
import 'orderDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  BottomNavigationBloc _bottomNavigationBloc;
  BuildContext _context;

  final List<Widget> _widgetOptions = [
    MenuScreen(),
    MyOrder(),
    ColleagueOrderScreen(),
    OrderDetailsScreen(),
  ];

  final List<String> _pageNames = [
    "Welcome",
    "My Order",
    "Order for a Colleague!",
    "Order Details",
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bottomNavigationBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
//    bottomNavigationBloc.clearAllData();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _bottomNavigationBloc.getOrderList();
    // TODO: implement build
    return BlocProvider(
      bloc: MenuBloc(),
      child: BlocProvider(
        bloc: MyOrderBloc(),
        child: BlocProvider(
          bloc: ColleagueOrderBloc(),
          child: BlocProvider(
            bloc: OrderDetailsBloc(),
            child: bottomBar(),
          ),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return StreamBuilder(
        stream: _bottomNavigationBloc.pageIndex,
        initialData: 0,
        builder: (context, snapshot) {
          return StreamBuilder(
              stream: _bottomNavigationBloc.pageNames,
              initialData: _pageNames,
              builder: (context, snapshot) {
                return StreamBuilder(
                    stream: _bottomNavigationBloc.appbarFlag,
                    builder: (context, appbarFlagSnapshot) {
                      return StreamBuilder(
                          stream: _bottomNavigationBloc.orderList,
                          builder: (context, orderListSnapshot) {
                            _bottomNavigationBloc
                                .setOrderHashMap(orderListSnapshot);
                            return Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.deepPurple,
                                title: Text(
                                  _pageNames[_currentPage],
                                ),
                                actions: <Widget>[
                                  appbarFlagSnapshot.data == null
                                      ? orderSummary(false)
                                      : orderSummary(
                                    appbarFlagSnapshot.data,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.exit_to_app,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Sign Out',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: const Text(
                                                'Are you sure to sign out?',
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    sessionManager
                                                        .signOut(_context);
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text('NO'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                ],
                              ),
                              bottomNavigationBar: FancyBottomNavigation(
                                circleColor: Colors.deepPurple,
                                activeIconColor: Colors.white,
                                inactiveIconColor: Colors.deepPurple,
                                tabs: [
                                  TabData(
                                      iconData: Icons.fastfood, title: "Menu"),
                                  TabData(
                                      iconData: Icons.favorite,
                                      title: "My Order"),
                                  TabData(
                                      iconData: Icons.supervisor_account,
                                      title: "Colleague's Order"),
                                  TabData(
                                      iconData: Icons.dashboard,
                                      title: "Order Details"),
//                    TabData(iconData: Icons.details, title: "Order Summary"),
                                ],
                                onTabChangedListener: (position) {
                                  setState(() {
                                    if (position == 3) {
                                      _bottomNavigationBloc
                                          .sinkAppbarFlag(true);
                                    } else {
                                      _bottomNavigationBloc
                                          .sinkAppbarFlag(false);
                                    }
                                    _currentPage = position;
                                  });
                                },
                              ),
//................General bottom navigation bar..............//
//                bottomNavigationBar: BottomNavigationBar(
//                  type: BottomNavigationBarType.fixed,
//                  onTap: bottomNavigationBloc.changedPageIndex,
//                  currentIndex: _currentIndex,
//                  fixedColor: Colors.deepPurple,
//                  items: <BottomNavigationBarItem>[
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.fastfood),
//                      title: Text("Menu"),
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.favorite),
//                      title: Text("My Order"),
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.supervisor_account),
//                      title: Text("Colleague's Order"),
//                    ),
//                  ],
//                ),
                              body: _widgetOptions[_currentPage],
                            );
                          });
                    });
              });
        });
  }

  Widget orderSummary(bool flag) {
    return Visibility(
      child: IconButton(
          icon: Icon(
            Icons.details,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {});
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return StreamBuilder(
                    stream: _bottomNavigationBloc.orderHashMap,
                    builder: (context, snapshot) {
                      var orders = snapshot.data;
                      return AlertDialog(
                        title: Text(
                          'ORDER SUMMARY',
                          textAlign: TextAlign.center,
                        ),
                        content: StreamBuilder(
                            stream: _bottomNavigationBloc.totalOrder,
                            builder: (context, snapshot) {
                              return Container(
                                height: 300.0,
                                width: 300.0,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        height: 250.0,
                                        width: 250.0,
                                        child: ListView.builder(
                                          itemCount: orders.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String key =
                                            orders.keys.elementAt(index);
                                            return Column(
                                              children: <Widget>[
                                                new ListTile(
                                                  title: new Text(
                                                    "$key: ${orders[key]}",
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                                new Divider(
                                                  height: 2.0,
                                                ),
                                              ],
                                            );
                                          },
                                        )),
                                    Expanded(
                                      child: Text(
                                          'Total Order: ${snapshot.data}',
                                          style: TextStyle(fontSize: 18.0)),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            );
          }),
      visible: flag,
    );
  }
}
