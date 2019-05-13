import 'package:flutter/material.dart';
import 'homepage.dart';
import 'login.dart';
import 'auth.dart';
import 'user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loading.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  bool loading = true;
  String name;

  initState() {
    super.initState();

    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  Future getName() async {
    var currentUser = await widget.auth.currentUser();
    var name = await Firestore.instance
        .collection('users')
        .document(currentUser)
        .get()
        .then((DocumentSnapshot ds) {
      return (ds.data["name"]);
    });
    var userDetails = {"name": name, "currentUser": currentUser};
    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LogIn(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return Container(
            child: FutureBuilder(
                future: getName(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["name"] != null)
                      return HomePage(
                        auth: widget.auth,
                        onSignedOut: _signedOut,
                      );
                    else {
                      return UserInfo(
                        auth: widget.auth,
                        onSignedOut: _signedOut,
                      );
                    }
                  } else {
                    return Loading();
                  }
                }));
    }
  }
}
