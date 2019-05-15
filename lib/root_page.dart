import 'package:flutter/material.dart';
import 'homepage.dart';
import 'login.dart';
import 'auth.dart';
import 'user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loading.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String emojiState = 'hello';
  String emoji;

  initState() {
    super.initState();
    getDetails().then((userDetails) => {
          setState(() {
            authStatus = userDetails['UID'] == null
                ? AuthStatus.notSignedIn
                : AuthStatus.signedIn;
          })
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

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Future getDetails() async {
    var currentUser = await getCurrentUser();
    var userDetails = await Firestore.instance
        .collection('users')
        .document(currentUser)
        .get()
        .then((DocumentSnapshot ds) {
      return (ds.data);
    });
    print(userDetails);
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
                future: getDetails(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print('snapshot');      
                  if (snapshot.hasData) {
                    print('has data');
                    if (snapshot.data["name"] != null) {
                      print('snapshot has data');

                      return HomePage(
                        auth: widget.auth,
                        onSignedOut: _signedOut,
                      );
                    } else {
                      return UserDetails(
                        auth: widget.auth,
                        onSignedOut: _signedOut,
                      );
                    }
                  } else {
                    print('load');
                    return HomePage();
                  }
                }));
    }
  }
}
