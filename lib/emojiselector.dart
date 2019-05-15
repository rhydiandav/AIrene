
import "package:flutter/material.dart";
import "./homepage.dart";
import "auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:intl/intl.dart";
import 'package:firebase_auth/firebase_auth.dart';


class EmojiSelector extends StatefulWidget {
  EmojiSelector({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _EmojiSelectorState createState() => _EmojiSelectorState();
}

class _EmojiSelectorState extends State<EmojiSelector> {

  var date = DateFormat('yyyy-MM-dd').format(new DateTime.now());


  void sendEmoji(emojiNumber, date) {
    try {
      widget.auth.currentUser().then((userId) {

        Firestore.instance.collection('users').document(userId).updateData({
          date: {"emoji": emojiNumber}
        });
      });
    } catch (e) {
      print('Error: $e');

    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How are you feeling today?"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "😀",
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    sendEmoji(5, date);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "🙂",
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    sendEmoji(4, date);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                )
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "😐",
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                )
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "🙁",
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {

                    sendEmoji(2, date);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                )
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "😢",
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    sendEmoji(1, date);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
