import 'package:flutter/material.dart';
import './homepage.dart';

class EmojiSelector extends StatelessWidget {
  @override
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
