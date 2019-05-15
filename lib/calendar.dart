import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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
  int emoji = 0;

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
    var formatter = new DateFormat('yyyy-MM-dd');
    var formattedDate = formatter.format(date);
    Firestore.instance
        .collection('users')
        .document(currentUser)
        .collection('history')
        .document(formattedDate)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        mood = ds['mood'];
        activity = ds['activity'];
        emoji = ds['emoji'];
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
          // if (clicked == false)
          //   Text('Nothing has been logged')
          // else
          // Text('Mood: ${mood}'),
          // Text('Activity: ${activity}'),
          // if (emoji == null)
          //   Text('Emoji: No Emoji')
          // else
          //   if (emoji == 5)
          //     Text('Emoji: 😃')
          //   else
          //     if (emoji == 4)
          //       Text('Emoji: 🙂')
          //     else
          //       if (emoji == 3)
          //         Text('Emoji: 😐')
          //       else
          //         if (emoji == 2)
          //           Text('Emoji: 🙁')
          //         else
          //           if (emoji == 1) Text('Emoji: ☹️'),
        ],
      ),
    );
  }
}
