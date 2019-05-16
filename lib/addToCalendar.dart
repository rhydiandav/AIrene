import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddToCalendar extends StatefulWidget {
  AddToCalendar({this.date});
  final String date;

  @override
  _AddToCalendarState createState() => _AddToCalendarState();
}

class _AddToCalendarState extends State<AddToCalendar> {
  final _formKey = GlobalKey<FormState>();
  String _activities;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  void validateAndSubmit() {
    print(widget.date);
    if (validateAndSave()) {
      try {
        getCurrentUser().then((userId) {
          print(_activities);
          Firestore.instance
              .collection('users')
              .document(userId)
              .collection('history')
              .document(widget.date)
              .setData({"activity": _activities}, merge: true);
        });
        Navigator.of(context).pop();
      } catch (e) {
        print('Failed to add activity: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add a new activity"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'activity',
              ),
              onSaved: (value) => _activities = value,
            ),
            RaisedButton(
                child: Text('Done!'),
                onPressed: () {
                  validateAndSubmit();
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
