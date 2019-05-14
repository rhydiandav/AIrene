import 'package:flutter/material.dart';
import 'homepage.dart';
import 'login.dart';
import 'auth.dart';
import 'user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'emojiselector.dart';

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
          // if(userDetails[('${DateFormat("yyyy-MM-dd").format(new DateTime.now())}')] == null ) {
          //   emoji = 'not today';
          //   return emoji}
          //   else { emoji = 'today';
          //   return emoji}
          emoji = userDetails[
                      '${DateFormat("yyyy-MM-dd").format(new DateTime.now())}'] !=
                  null
              ? 'today'
              : 'not today',

          setState(() {
            authStatus = userDetails['UID'] == null
                ? AuthStatus.notSignedIn
                : AuthStatus.signedIn;

            // if (userDetails[
            //         '${DateFormat("yyyy-MM-dd").format(new DateTime.now())}'] !=
            //     null) {
            //   emojiState = 'today';
            // } else {
            //   emojiState = 'not today';
            // }
            emojiState = emoji;

            print(emojiState);
            //     ? 'not today'
            //     :
            // 'today';
          })
        });
    // widget.auth.currentUser().then((userId) {
    // _didEmoji();
  }

  // Future<void> _didEmoji() async {
  //   print(widget.auth);
  //   widget.auth.currentUser().then((userId) => {
  //         print(userId),
  //         Firestore.instance
  //             .collection("users")
  //             .document(userId)
  //             .get()
  //             .then((DocumentSnapshot ds) {
  //           if (ds.data[
  //                   '${DateFormat("yyyy-MM-dd").format(new DateTime.now())}'] ==
  //               null) {
  //             print("no emoji today");
  //             setState(() {
  //               emojiState = "not today";
  //             });
  //           } else {
  //             print("you have entered an emoji today");
  //             setState(() {
  //               emojiState = "today";
  //             });
  //           }
  //         }),
  //       });
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
                      // if (emojiState == 'today') {
                      //   print('emoji is today');
                      return HomePage(
                        auth: widget.auth,
                        onSignedOut: _signedOut,
                      );
                      // } else if (emojiState == 'not today') {
                      //   print('emoji here');
                      //   return EmojiSelector(
                      //     auth: widget.auth,
                      //     onSignedOut: _signedOut,
                      //   );
                      // }
                    } else {
                      return UserDetails(
                        auth: widget.auth,
                        onSignedOut: _signedOut,
                      );
                      // }
                    }
                  } else {
                    print('load');
                    return Loading();
                  }
                }));
    }
  }
}
