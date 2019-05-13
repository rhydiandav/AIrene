import 'package:flutter/material.dart';
import './homepage.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmojiSelector extends StatefulWidget {
  EmojiSelector({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _EmojiSelectorState createState() => _EmojiSelectorState();
}

class _EmojiSelectorState extends State<EmojiSelector> {
  int _emoji;

  void sendEmoji(emojiNumber) {
    try {
      //post name dob gender hobbies to db
      widget.auth.currentUser().then((userId) {
        Firestore.instance.collection('users').document(userId).updateData({
          "date": DateTime.now().millisecondsSinceEpoch,
          "emoji": emojiNumber
        });
      });
    } catch (e) {
      //error
      print('Error: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How are you feeling today?'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    '😃',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    sendEmoji(5);
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
                    '🙂',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    sendEmoji(4);
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
                    '😐',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    sendEmoji(3);
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
                    '🙁',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    sendEmoji(2);
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
                    '☹️',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  onTap: () {
                    sendEmoji(1);
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
