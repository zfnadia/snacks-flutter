import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/loginBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

class LoginScreen extends StatelessWidget {
  final Color foregroundColor = Colors.white;
  final Color highlightColor = Colors.teal[100];
  BuildContext context;
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of(context);
    return Container(
      //gradient background
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.blue, Colors.red],
      )),
      //main body starts here
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          image: DecorationImage(
                            image: new AssetImage('assets/bdjobs_logo_img.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _emailAddressField(),
              _passwordFiled(),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailAddressField() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: this.foregroundColor,
              width: 0.5,
              style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
            child: Icon(
              Icons.alternate_email,
              color: this.foregroundColor,
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _loginBloc.emailAddress,
                builder: (context, snapshot) {
                  return TextField(
                    style: new TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                    cursorColor: this.foregroundColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    onChanged: (value) {
                      _loginBloc.sinkEmail(value);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _passwordFiled() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: this.foregroundColor,
              width: 0.5,
              style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
            child: Icon(
              Icons.lock_open,
              color: this.foregroundColor,
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _loginBloc.password,
                initialData: '',
                builder: (context, snapshot) {
                  return TextField(
                    style: new TextStyle(color: Colors.white),
                    obscureText: true,
                    textAlign: TextAlign.start,
                    cursorColor: this.foregroundColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    onChanged: (value) {
                      _loginBloc.sinkPassword(value);
                    },
                  );
                }),
//            child:
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Container(
//      width: MediaQuery.of(_context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _loginBloc.loginDataValid,
              builder: (context, snapshot) {
                return FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: this.foregroundColor)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
//                        color: this.highlightColor,
                  onPressed: snapshot.hasData
                      ? () {
                          _loginBloc.submitLoginData(context);
                        }
                      : null,
                  child: Text(
                    "Log In",
                    style: TextStyle(color: this.foregroundColor),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
