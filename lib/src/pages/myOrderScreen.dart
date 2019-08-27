import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/loginBloc.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/myOrderBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

import 'menuScreen.dart';

class MyOrder extends StatelessWidget {
  MyOrderBloc _myOrderBloc;
  MenuBloc _menuBloc;
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _myOrderBloc = BlocProvider.of(context);
    _menuBloc = BlocProvider.of(context);
    _loginBloc = BlocProvider.of(context);
    _loginBloc.sinkConnectionStatus(false);
    _loginBloc.checkConnectionStatus();
    _menuBloc.showMenu();
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: _loginBloc.connectionStatus,
            builder: (context, connectionStatusSnapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                                  ? () async {
                                var presentOrderMsgType = await
                                _myOrderBloc.viewPresentOrder();
                                if (presentOrderMsgType.toString() == "0") {
                                  _myOrderBloc.sendOrder();
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return showAlertDialog(
                                          context,
                                          'Order Submitted',
                                          'Your order has been submitted successfully!');
                                    },
                                  );
                                } else {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return showAlertDialog(
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
                    height: 10.0,
                  ),
                  MenuScreen.internetStatus(connectionStatusSnapshot),
                ],
              );
            }
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
                    return radioItem(_myOrderBloc, snapshot, _radioValue);
                  }),
              StreamBuilder(
                stream: _menuBloc.altMenuOne,
                builder: (context, snapshot) {
                  return radioItem(_myOrderBloc, snapshot, _radioValue);
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuTwo,
                builder: (context, snapshot) {
                  return radioItem(_myOrderBloc, snapshot, _radioValue);
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuThree,
                builder: (context, snapshot) {
                  return radioItem(_myOrderBloc, snapshot, _radioValue);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "**Please note that you can place the order only once**",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          );
        });
  }

  static Widget radioItem(_bloc, snapshot, _radioValue) {
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
                _bloc.changeMyOrder(value);
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
  }

  static Widget showAlertDialog(BuildContext context, String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
