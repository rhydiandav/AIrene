import 'package:flutter/material.dart';
import 'package:project/emojiselector.dart';
import 'homepage.dart';
import 'login.dart';
import 'auth.dart';
import 'user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        userId = userId;
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

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LogIn(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        // widget.auth.currentUser().then((userId) {
        //   Firestore.instance
        //       .collection('users')
        //       .document(userId)
        //       .get()
        //       .then((DocumentSnapshot ds) {
        //     print(ds.data["UID"]);
        //     if (ds.data["name"]) {
        return EmojiSelector(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );

      // return HomePage(
      //   auth: widget.auth,
      //   onSignedOut: _signedOut,
      // );
      // } else {
      //   return UserInfo;
      // }
      // });
    }
    // );
  }
}
