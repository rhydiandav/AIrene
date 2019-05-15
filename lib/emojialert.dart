import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EmojiAlert extends StatelessWidget {
  // EmojiAlert({this.emojiPresent});
  // String emojiPresent;

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  final now = DateFormat("yyyy-MM-dd").format(new DateTime.now());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("How are you feeling today?"),
      content: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                    child: Text(
                      '😀',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .updateData({
                            now: {'emoji': 5}
                          });
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    child: Text('🙂', style: TextStyle(fontSize: 30.0)),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .updateData({
                            now: {'emoji': 4}
                          });
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    child: Text('😐', style: TextStyle(fontSize: 30.0)),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .updateData({
                            now: {'emoji': 3}
                          });
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    child: Text('🙁', style: TextStyle(fontSize: 30.0)),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .updateData({
                            now: {'emoji': 2}
                          });
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    child: Text('😢', style: TextStyle(fontSize: 30.0)),
                    onTap: () {
                      try {
                        getCurrentUser().then((userId) {
                          Firestore.instance
                              .collection("users")
                              .document(userId)
                              .updateData({
                            now: {'emoji': 1}
                          });
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
      actions: <Widget>[
        new FlatButton(
          child: new Text("OK"),
          onPressed: () {
            print('here...');
            try {
              getCurrentUser().then((userId) {
                Firestore.instance
                    .collection("users")
                    .document(userId)
                    .updateData({
                  now: {'emoji': 5}
                });
              });
            } catch (e) {
              print("Error: $e");
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
