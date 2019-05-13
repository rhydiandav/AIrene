import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ChartsPage extends StatefulWidget {
  ChartsPage({this.auth});

  final BaseAuth auth;

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  String userName;

  Future<void> _getData() async {
    print(widget.auth);
    widget.auth.currentUser().then((userId) => {
          print(userId),
          Firestore.instance
              .collection('users')
              .document(userId)
              .get()
              .then((DocumentSnapshot ds) {
            userName = ds.data["name"];
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(
          'My Data Here',
        ),
      ),
    );
  }
}
