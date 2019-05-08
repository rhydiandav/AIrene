import 'package:flutter/material.dart';
import './emojiselector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Form(
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            RaisedButton(
              child: Text('LogIn'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmojiSelector()),
                );
              },
            ),
            StreamBuilder<Object>(
                stream: Firestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  print(snapshot);
                  return const Text('Hellooo...');
                }),
          ]),
        ),
      ),
    );
  }
}
