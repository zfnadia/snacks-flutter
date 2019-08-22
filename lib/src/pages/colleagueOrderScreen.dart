import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/colleagueOrderBloc.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/myOrderBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/modelClasses/userListModel.dart';

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
                              var presentOrderMsgType = _colleagueOrderBloc
                                  .viewPresentOrder()
                                  .toString();
                              if (presentOrderMsgType == "1") {
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
                                            _colleagueOrderBloc
                                                .sendColleagueOrder();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Please Note',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: const Text(
                                          'You have already placed the order for today!'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
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
          var _radioValue =
              snapshot.hasData && snapshot.data is String ? snapshot.data : "";
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
                            snapshot.hasData && snapshot.data is String
                                ? snapshot.data.toString()
                                : "",
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
                            snapshot.hasData && snapshot.data is String
                                ? snapshot.data.toString()
                                : "",
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
                            snapshot.hasData && snapshot.data is String
                                ? snapshot.data.toString()
                                : "",
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
                            snapshot.hasData && snapshot.data is String
                                ? snapshot.data.toString()
                                : "",
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
            builder: (context, outerSnapshot) {
              return outerSnapshot.hasData &&
                      outerSnapshot.data is UserListModel &&
                      outerSnapshot.data != null
                  ? StreamBuilder(
                      stream: _colleagueOrderBloc.userDropdownValue,
                      builder: (context, innerSnapshot) {
                        List<User> userList = outerSnapshot.data.users.toList();
                        _colleagueOrderBloc
                            .changeUserDropdownValue(userList[0]);
                        return DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: Center(
                              child: DropdownButton<User>(
                                items: userList.map((User item) {
                                  return DropdownMenuItem<User>(
                                    child: Text(item.uname),
                                    value: item,
                                  );
                                }).toList(),
                                onChanged:
                                    _colleagueOrderBloc.changeUserDropdownValue,
                                value: innerSnapshot.data,
                                style: Theme.of(context).textTheme.title,
                                isExpanded: true,
                              ),
                            ),
                          ),
                        );
                      })
                  : Text('Loading');
            }),
      ),
    );
  }
}
