import 'package:flutter/material.dart';
import 'auth.dart';
import 'root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project',
       home: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Colors.grey[100],
                Colors.grey[200],
                Colors.grey[300],
                Colors.grey[400],
              ],
            )),
            child: RootPage(auth: Auth())),
         theme: ThemeData(
            primaryColor: Colors.teal[200],
            accentColor: Colors.teal[300],
            fontFamily: 'Helvetica',
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            )));
  }
}
