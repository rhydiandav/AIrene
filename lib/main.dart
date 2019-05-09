import 'package:flutter/material.dart';
import 'login.dart';
import 'auth.dart';
import 'root_page.dart';

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
        body: new RootPage(auth: new Auth()),
      ),
    );
  }
}
