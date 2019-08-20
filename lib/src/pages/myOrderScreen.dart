import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/menuBloc.dart';
import 'package:snacks_app/src/blocs/myOrderBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

class MyOrder extends StatelessWidget {
  MyOrderBloc _myOrderBloc;
  MenuBloc _menuBloc;

  @override
  Widget build(BuildContext context) {
    _menuBloc = BlocProvider.of(context);

    _menuBloc.showMenu();
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select menu',
            style: TextStyle(fontSize: 30),
          ),
          radioButtons(),
          StreamBuilder(
              stream: _myOrderBloc.radioBtnOrderValue,
              builder: (context, snapshot) {
                print(snapshot.data);
                return RaisedButton(
                  child: Text('Order'),
//                  onPressed: snapshot.hasData ? () {} : null,
                );
              })
        ],
      ),
    ));
  }

  Widget radioButtons() {
    return StreamBuilder(
        stream: _myOrderBloc.radioBtnOrderValue,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: _menuBloc.mainMenu,
                builder: (context, snapshot) {
                  return Row(
                    children: <Widget>[
                      Radio(
                        value: snapshot.data,
                        groupValue: snapshot.data,
                        onChanged: (value) {
                          _myOrderBloc.changeMyOrder(value);
                        },
                      ),
                      Text(snapshot.data)
                    ],
                  );
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuOne,
                builder: (context, snapshot) {
                  return Row(
                    children: <Widget>[
                      Radio(
                        value: snapshot.data,
                        groupValue: snapshot.data,
                        onChanged: (value) {
                          _myOrderBloc.changeMyOrder(value);
                        },
                      ),
                      Text(snapshot.data)
                    ],
                  );
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuTwo,
                builder: (context, snapshot) {
                  return Row(
                    children: <Widget>[
                      Radio(
                        value: snapshot.data,
                        groupValue: snapshot.data,
                        onChanged: (value) {
                          _myOrderBloc.changeMyOrder(value);
                        },
                      ),
                      Text(snapshot.data)
                    ],
                  );
                },
              ),
              StreamBuilder(
                stream: _menuBloc.altMenuThree,
                builder: (context, snapshot) {
                  return Row(
                    children: <Widget>[
                      Radio(
                        value: snapshot.data,
                        groupValue: snapshot.data,
                        onChanged: (value) {
//                          _myOrderBloc.changeMyOrder(value);
                        },
                      ),
                      Text(snapshot.data)
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}
