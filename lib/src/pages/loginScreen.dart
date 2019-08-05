import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final Color foregroundColor = Colors.white;
  final Color highlightColor = Colors.teal[100];

  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//          child: ListView(
//        padding: EdgeInsets.all(20.0),
//        children: <Widget>[
//          SizedBox(
//            height: 60.0,
//          ),
//          _loginHeader(),
//          SizedBox(
//            height: 20.0,
//          ),
//          _usernameTextField(),
//          SizedBox(
//            height: 20.0,
//          ),
//          _passwordTextField(),
//          SizedBox(
//            height: 20.0,
//          ),
//          _loginButton(),
//          SizedBox(
//            height: 100.0,
//          ),
//        ],
//      )),
//    );
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
                        height: 128.0,
                        width: 128.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundColor: this.foregroundColor,
                          radius: 100.0,
                          child: Text(
                            "N",
                            style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: this.foregroundColor,
                            width: 1.0,
                          ),
                          shape: BoxShape.circle,
                          //image: DecorationImage(image: this.logo)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Nadia Ferdoush",
                          style: TextStyle(color: this.foregroundColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
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
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                      child: Icon(
                        Icons.alternate_email,
                        color: this.foregroundColor,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: new TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        cursorColor: this.foregroundColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'dummy@live.com',
                          hintStyle: TextStyle(color: this.foregroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
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
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                      child: Icon(
                        Icons.lock_open,
                        color: this.foregroundColor,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: new TextStyle(color: Colors.white),
                        obscureText: true,
                        textAlign: TextAlign.center,
                        cursorColor: this.foregroundColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '*********',
                          hintStyle: TextStyle(color: this.foregroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: this.foregroundColor)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
//                        color: this.highlightColor,
                        onPressed: () => {},
                        child: Text(
                          "Log In",
                          style: TextStyle(color: this.foregroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        color: Colors.transparent,
                        onPressed: () => {},
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                              color: this.foregroundColor.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Divider(),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        color: Colors.transparent,
                        onPressed: () => {},
                        child: Text(
                          "Don't have an account? Create One",
                          style: TextStyle(
                              color: this.foregroundColor.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//@override
//Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//          child: ListView(
//        padding: EdgeInsets.all(20.0),
//        children: <Widget>[
//          SizedBox(
//            height: 60.0,
//          ),
//          _loginHeader(),
//          SizedBox(
//            height: 20.0,
//          ),
//          _usernameTextField(),
//          SizedBox(
//            height: 20.0,
//          ),
//          _passwordTextField(),
//          SizedBox(
//            height: 20.0,
//          ),
//          _loginButton(),
//          SizedBox(
//            height: 100.0,
//          ),
//        ],
//      )),
//    );
//}

//  Widget _loginHeader() {
//    return Text('Login',
//        style: TextStyle(
//          fontWeight: FontWeight.bold,
//          fontSize: 36.0,
//        ));
//  }
//
//  Widget _usernameTextField() {
//    return StreamBuilder(
////      stream: bloc.email,
//      builder: (context, snapshot) {
//        return TextField(
////          onChanged: bloc.changeEmail,
//          decoration: InputDecoration(
//            border: OutlineInputBorder(),
//            labelText: 'Enter your username',
//            errorText: snapshot.error,
//          ),
//        );
//      },
//    );
//  }
//
//  Widget _passwordTextField() {
//    return StreamBuilder(
////      stream: bloc.password,
//      builder: (context, snapshot) {
//        return TextField(
////          onChanged: bloc.changePassword,
//          obscureText: true,
//          decoration: InputDecoration(
//            border: OutlineInputBorder(),
//            labelText: 'Enter your password',
//            errorText: snapshot.error,
//          ),
//        );
//      },
//    );
//  }
//
//  Widget _loginButton() {
//    return StreamBuilder(
////      stream: bloc.loginDataValid,
//      builder: (context, snapshot) {
//        return RaisedButton(
//          onPressed: snapshot.hasData
//              ? () {
////            bloc.submitLoginData(context);
//                }
//              : null,
//          child: Text(
//            'Log In',
//            style: TextStyle(color: Colors.white),
//          ),
//        );
//      },
//    );
//  }
//}
