import 'package:flutter/material.dart';
import './emojiselector.dart';

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
            Text('Sign Up Here'),
          ]),
        ),
      ),
    );
  }
}
