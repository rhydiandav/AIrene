import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:project/addToCalendar.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Diary'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Colors.white,
                Colors.pink[50],
                Colors.indigo[50],
                Colors.white,
              ],
            ),
          ),
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Calendar(
                  onDateSelected: (date) => {
                        setState(() {
                          newDate = date;
                        }),
                        handleNewDate(date),
                      },
                  isExpandable: true,
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal[400],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: <Widget>[
                              Text(
                                'Mood:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue[50],
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Share'),
                              ),
                              Text(' $mood',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue[50],
                                      fontSize: 25,
                                      fontFamily: 'Bad Script'))
                            ],
                          ),
                          activity == null
                              ? Text('Please add your activity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue[50],
                                      fontSize: 25,
                                      fontFamily: 'Bad Script'))
                              : Column(children: [
                                  Text('Activity: ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.blue[50],
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Share')),
                                  Text('$activity',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.blue[50],
                                          fontSize: 25,
                                          fontFamily: 'Bad Script'))
                                ]),
                          (emoji == null)
                              ? Column(children: [
                                  Text('Emoji:',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.blue[50],
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Share')),
                                  Text('No Emoji',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.blue[50],
                                          fontSize: 25,
                                          fontFamily: 'Bad Script'))
                                ])
                              : (emoji == 5)
                                  ? Column(children: [
                                      Text('Emoji:',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blue[50],
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Share')),
                                      Text(' 😃',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.blue[50],
                                            fontSize: 25,
                                          ))
                                    ])
                                  : (emoji == 4)
                                      ? Column(children: [
                                          Text('Emoji:',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.blue[50],
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Share')),
                                          Text('🙂',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.blue[50],
                                                fontSize: 25,
                                              ))
                                        ])
                                      : (emoji == 3)
                                          ? Column(children: [
                                              Text('Emoji:',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.blue[50],
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Share')),
                                              Text('😐',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.blue[50],
                                                      fontSize: 25))
                                            ])
                                          : (emoji == 2)
                                              ? Column(children: [
                                                  Text('Emoji:',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[50],
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Share')),
                                                  Text('🙁',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.blue[50],
                                                        fontSize: 25,
                                                      ))
                                                ])
                                              : (emoji == 1)
                                                  ? Column(children: [
                                                      Text('Emoji:',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue[50],
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Share')),
                                                      Text('☹️',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.blue[50],
                                                            fontSize: 25,
                                                          ))
                                                    ])
                                                  : Column(children: [
                                                      Text('Emoji:',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue[50],
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Share')),
                                                      Text('No Emoji',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue[50],
                                                              fontSize: 25,
                                                              fontFamily:
                                                                  'Bad Script'))
                                                    ])
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.blue[50],
          ),
          onPressed: () {
            _showDialog('activity', newDate);
          },
          backgroundColor: Colors.teal[200],
        ));
  }
}
