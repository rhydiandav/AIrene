import 'package:flutter/material.dart';
import './chatbot.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: new GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(3.0),
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          children: <Widget>[
            GridTile(
              child: Icon(const IconData(59701, fontFamily: 'MaterialIcons')),
            ),
            GridTile(
              child: Icon(const IconData(58902,
                  fontFamily: 'MaterialIcons', matchTextDirection: true)),
            ),
            GridTile(
              child: Icon(const IconData(57936, fontFamily: 'MaterialIcons')),
            ),
            GridTile(
              child: Icon(const IconData(59517, fontFamily: 'MaterialIcons')),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(const IconData(57527, fontFamily: 'MaterialIcons')),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Chatbot()));
          }),
    );
  }
}
