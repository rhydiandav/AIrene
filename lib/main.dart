import 'package:flutter/material.dart';
import './login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Log In'),
        ),
        body: LogIn(),
      ),
    );
  }
}
