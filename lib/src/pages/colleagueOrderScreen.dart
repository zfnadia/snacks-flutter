import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/colleagueOrderBloc.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/myOrderBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

class ColleagueOrderScreen extends StatelessWidget {
  MyOrderBloc _myOrderBloc;
  MenuBloc _menuBloc;
  ColleagueOrderBloc _colleagueOrderBloc;

  @override
  Widget build(BuildContext context) {
    _colleagueOrderBloc = BlocProvider.of(context);
    _myOrderBloc = BlocProvider.of(context);
    _menuBloc = BlocProvider.of(context);
    _menuBloc.showMenu();
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Colleague's Name:",
                  style: TextStyle(fontSize: 19.0, color: Colors.grey),
                ),
              ),
              personDropDown(),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Select Menu',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20.0,
          ),
          radioButtons(),
          SizedBox(
            height: 20.0,
          ),
          StreamBuilder(
              stream: _myOrderBloc.radioBtnOrderValue,
              builder: (context, snapshot) {
                return Container(
                  width: 250,
                  child: RaisedButton(
                      onPressed: snapshot.hasData
                          ? () {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Order Submitted'),
                                    content: const Text(
                                        'Your order has been submitted successfully!'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _myOrderBloc.sendOrder();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          : null,
                      textColor: Colors.white,
                      color: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.donut_large),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Submit Order",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )),
                );
              }),
        ],
      ),
    ));
  }

  Widget radioButtons() {
    return StreamBuilder(
        stream: _myOrderBloc.radioBtnOrderValue,
        builder: (context, snapshot) {
          var _radioValue = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                stream: _menuBloc.mainMenu,
                builder: (context, snapshot) {
                  return Container(
                    height: 70.0,
                    width: double.infinity,
                    child: Card(
                      elevation: 4.0,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: snapshot.data,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              _myOrderBloc.changeMyOrder(value);
                            },
                          ),
                          Text(
                            snapshot.data,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuOne,
                builder: (context, snapshot) {
                  return Container(
                    height: 70.0,
                    width: double.infinity,
                    child: Card(
                      elevation: 4.0,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: snapshot.data,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              _myOrderBloc.changeMyOrder(value);
                            },
                          ),
                          Text(
                            snapshot.data,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuTwo,
                builder: (context, snapshot) {
                  return Container(
                    height: 70.0,
                    width: double.infinity,
                    child: Card(
                      elevation: 4.0,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: snapshot.data,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              _myOrderBloc.changeMyOrder(value);
                            },
                          ),
                          Text(
                            snapshot.data,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuThree,
                builder: (context, snapshot) {
                  return Container(
                    height: 70.0,
                    width: double.infinity,
                    child: Card(
                      elevation: 4.0,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: snapshot.data,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              _myOrderBloc.changeMyOrder(value);
                            },
                          ),
                          Text(
                            snapshot.data,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  Widget personDropDown() {
    _colleagueOrderBloc.showUserList();

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.0, style: BorderStyle.solid, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: StreamBuilder(
            stream: _colleagueOrderBloc.userList,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                List<String> userList = List<String>();
                userList.clear();
                snapshot.data.users
                    .forEach((element) => userList.add(element.uname));
                _colleagueOrderBloc.changeUserDropdownValue(userList[0]);
                return StreamBuilder(
                    stream: _colleagueOrderBloc.userDropdownValue,
                    builder: (context, snapshot) {
                      return DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: Center(
                            child: DropdownButton<String>(
                              hint: Text('Select'),
                              items: userList.map((String item) {
                                return DropdownMenuItem<String>(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged:
                                  _colleagueOrderBloc.changeUserDropdownValue,
                              value: snapshot.hasData
                                  ? snapshot.data
                                  : userList[0],
                              style: Theme.of(context).textTheme.title,
                              isExpanded: true,
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Text('Loading');
              }
            }),
      ),
    );
  }
}
