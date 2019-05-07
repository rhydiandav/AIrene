import 'package:flutter/material.dart';
import './main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  '😐',
                  style: TextStyle(fontSize: 50.0),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  '☹️',
                  style: TextStyle(fontSize: 50.0),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
