import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calendar'),
        ),
        body: CalendarViewApp());
  }
}

class CalendarViewApp extends StatefulWidget {
  @override
  _CalendarViewAppState createState() => _CalendarViewAppState();
}

class _CalendarViewAppState extends State<CalendarViewApp> {
  String mood = '';
  String activity = '';
  String currentUser = '';

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  initState() {
    getCurrentUser().then((userId) {
      currentUser = userId;
    });
    super.initState();
  }

  void handleNewDate(date) {
    print("handleNewDate $date");
    Firestore.instance
        .collection('users')
        .document(currentUser)
        .collection('history')
        .document('2019-05-13')
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        mood = ds['mood'];
        activity = ds['activity'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 10.0,
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Calendar(
            onSelectedRangeChange: (range) =>
                print("Range is ${range.item1}, ${range.item2}"),
            onDateSelected: (date) => handleNewDate(date),
            isExpandable: true,
          ),
          Divider(
            height: 50.0,
          ),
          Text(mood),
          Text(activity)
        ],
      ),
    );
  }
}
