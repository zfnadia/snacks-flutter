import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/colleagueOrderBloc.dart';
import 'package:snacks_app/src/blocs/loginBloc.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/pages/menuScreen.dart';
import 'package:snacks_app/src/repository/modelClasses/userListModel.dart';
import 'package:snacks_app/src/pages/myOrderScreen.dart';
import 'package:snacks_app/src/sessionManager/sessionManager.dart';

class ColleagueOrderScreen extends StatelessWidget {
  MenuBloc _menuBloc;
  ColleagueOrderBloc _colleagueOrderBloc;
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _colleagueOrderBloc = BlocProvider.of(context);
    _menuBloc = BlocProvider.of(context);
    _loginBloc = BlocProvider.of(context);
    _loginBloc.sinkConnectionStatus(false);
    _loginBloc.checkConnectionStatus();
    _menuBloc.showMenu();
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.all(16.0),
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
          style: TextStyle(fontSize: 25.0),
        ),
        SizedBox(
          height: 20.0,
        ),
        radioButtons(),
        SizedBox(
          height: 20.0,
        ),
        StreamBuilder(
            stream: _colleagueOrderBloc.radioBtnOrderValue,
            builder: (context, snapshot) {
              return Container(
                width: 250,
                child: RaisedButton(
                    onPressed: snapshot.hasData
                        ? () async {
                            var presentOrderMsgType;
                            presentOrderMsgType =
                                await _colleagueOrderBloc.viewPresentOrder();
                            if (presentOrderMsgType.toString() == "0") {
                              _colleagueOrderBloc.sendColleagueOrder();
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return MyOrder.showAlertDialog(
                                      context,
                                      'Order Submitted',
                                      'Your order has been submitted successfully!');
                                },
                              );
                            } else {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return MyOrder.showAlertDialog(
                                      context,
                                      'Please Note',
                                      'You have already placed the order for today!');
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(
          height: 100.0,
        ),
      ],
    ));
  }

  Widget radioButtons() {
    return StreamBuilder(
        stream: _colleagueOrderBloc.radioBtnOrderValue,
        builder: (context, snapshot) {
          var _radioValue =
              snapshot.hasData && snapshot.data is String ? snapshot.data : "";
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                stream: _menuBloc.mainMenu,
                builder: (context, snapshot) {
                  return MyOrder.radioItem(
                      _colleagueOrderBloc, snapshot, _radioValue);
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuOne,
                builder: (context, snapshot) {
                  return MyOrder.radioItem(
                      _colleagueOrderBloc, snapshot, _radioValue);
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuTwo,
                builder: (context, snapshot) {
                  return MyOrder.radioItem(
                      _colleagueOrderBloc, snapshot, _radioValue);
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuThree,
                builder: (context, snapshot) {
                  return MyOrder.radioItem(
                      _colleagueOrderBloc, snapshot, _radioValue);
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
                        if (userList.length > 0 &&
                            userList[0].uname != "Select") {
                          userList.insert(
                              0,
                              User(
                                  uname: "Select",
                                  gid: null,
                                  messageType: "0"));
                        }
                        return DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: Center(
                              child: DropdownButton<User>(
                                hint: Text("Select"),
                                value: innerSnapshot.hasData
                                    ? innerSnapshot.data
                                    : userList[0],
                                items: userList.map((User item) {
                                  return DropdownMenuItem<User>(
                                    child: Text(item.uname),
                                    value: item,
                                  );
                                }).toList(),
                                //selected value of the list
                                style: Theme.of(context).textTheme.title,
                                isExpanded: true,
                                onChanged: (value) {
                                  if (value.gid == null) {
                                    return;
                                  }
                                  _colleagueOrderBloc
                                      .changeUserDropdownValue(value);
                                },
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
