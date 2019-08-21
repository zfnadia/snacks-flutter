import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/myOrderBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

class MyOrder extends StatelessWidget {
  MyOrderBloc _myOrderBloc;
  MenuBloc _menuBloc;

  @override
  Widget build(BuildContext context) {
    _myOrderBloc = BlocProvider.of(context);
    _menuBloc = BlocProvider.of(context);
    _menuBloc.showMenu();
//    if (_myOrderBloc.viewPresentOrder() == "1") {
      return Scaffold(
          body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
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
//    } else {
//          return AlertDialog(
//            title: Text('Please Note'),
//            content: const Text(
//                'You have already placed your order for today!'),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('OK'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//
//                },
//              ),
//            ],
//          );
//    }
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
}
