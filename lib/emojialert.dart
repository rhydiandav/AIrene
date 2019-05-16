import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EmojiAlert extends StatelessWidget {
  EmojiAlert({this.emojiPresent});
  String emojiPresent;

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  final now = DateFormat("yyyy-MM-dd").format(new DateTime.now());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      title: Text("How are you feeling today?",
          style: TextStyle(fontFamily: 'Bad Script', fontSize: 50),
          textAlign: TextAlign.center,
          textScaleFactor: .7),
      content: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    child: Text(
                      '😀',
                      style: TextStyle(fontSize: 80.0),
                    ),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .collection("history")
                              .document(now)
                              .setData({'emoji': 5});
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    child: Text('🙂', style: TextStyle(fontSize: 75.0)),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .collection("history")
                              .document(now)
                              .setData({'emoji': 4});
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    child: Text('😐', style: TextStyle(fontSize: 70.0)),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .collection("history")
                              .document(now)
                              .setData({'emoji': 3});
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    child: Text('🙁', style: TextStyle(fontSize: 65.0)),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .collection("history")
                              .document(now)
                              .setData({'emoji': 2});
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    child: Text('😢', style: TextStyle(fontSize: 60.0)),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .collection("history")
                              .document(now)
                              .setData({'emoji': 1});
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
