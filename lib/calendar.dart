import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:project/addToCalendar.dart';

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
  DateTime newDate;
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

  handleNewDate(date) {
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
        mood = ds.exists ? ds['mood'] : "No mood recorded";
        activity = ds.exists ? ds['activity'] : "No activity recorded";
        emoji = ds['emoji'];
      });
    });
  }

  void _showDialog(setting, newDate) {
    var formatter = new DateFormat('yyyy-MM-dd');
    var formattedDate = formatter.format(newDate);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddToCalendar(date: formattedDate);
        });
  }

  @override
  Widget build(BuildContext context) {
    print(mood);
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
              onDateSelected: (date) => {
                    setState(() {
                      newDate = date;
                    }),
                    handleNewDate(date),
                  },
              isExpandable: true,
            ),
            Divider(
              height: 50.0,
            ),
            Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.pink,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    _showDialog('activity', newDate);
                  },
                ),
              ),
            ),
            Text('Mood: ${mood}'),
            activity == null
                ? Text('Please add your activity')
                : Text('Activity: ${activity}'),
            (emoji == null)
                ? Text('Emoji: No Emoji')
                : (emoji == 5)
                    ? Text('Emoji: 😃')
                    : (emoji == 4)
                        ? Text('Emoji: 🙂')
                        : (emoji == 3)
                            ? Text('Emoji: 😐')
                            : (emoji == 2)
                                ? Text('Emoji: 🙁')
                                : (emoji == 1)
                                    ? Text('Emoji: ☹️')
                                    : Text('Emoji: No Emoji')
          ],
        ));
  }
}
