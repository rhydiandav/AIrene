import 'package:flutter/material.dart';
import 'package:project/emojiselector.dart';
import 'homepage.dart';
import 'login.dart';
import 'auth.dart';
// import 'user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  String emojiState = '';
  // today

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      _didEmoji();

      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        userId = userId;
      });
    });

    // setState(() {
    //   emojiState = 'today';

    // });
  }

  Future<void> _didEmoji() async {
    print(widget.auth);
    widget.auth.currentUser().then((userId) => {
          print(userId),
          Firestore.instance
              .collection('users')
              .document(userId)
              .get()
              .then((DocumentSnapshot ds) {
            if (ds.data[
                    "${DateFormat('yyyy-MM-dd').format(new DateTime.now())}"] ==
                null) {
              print('no emoji today');
              setState(() {
                emojiState = 'not today';
              });
            } else {
              print('you have entered an emoji today');
              setState(() {
                emojiState = 'today';
              });
            }
          }),
        });
  }

  // initState() {
  //   super.initState();
  //   widget.auth.currentUser().then((userId) {
  //     setState(() {
  //       authStatus =
  //           userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
  //       userId = userId;
  //     });
  //   });
  // }

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
        {
          switch (emojiState) {
            case 'today':
              return HomePage(
                auth: widget.auth,
                onSignedOut: _signedOut,
              );
            case 'not today':
              return EmojiSelector(
                auth: widget.auth,
                onSignedOut: _signedOut,
              );
          }
        }
      // case AuthStatus.signedIn:
      // widget.auth.currentUser().then((userId) {
      //   Firestore.instance
      //       .collection('users')
      //       .document(userId)
      //       .get()
      //       .then((DocumentSnapshot ds) {
      //     print(ds.data["UID"]);
      //     if (ds.data["name"]) {

      // TODO if(there is a container with todays date on the user then navigate to hompage if not navigate to emoji page)
// if(Firestore.instance.collection('users').document(userId) == )

      // return EmojiSelector(
      //   auth: widget.auth,
      //   onSignedOut: _signedOut,
      // );

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
