import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class BirthdaySettings extends StatefulWidget {
  BirthdaySettings({this.auth});
  final BaseAuth auth;
  @override
  _BirthdaySettingsState createState() => _BirthdaySettingsState();
}

class _BirthdaySettingsState extends State<BirthdaySettings> {
  String _location;

  final _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      try {
        widget.auth.currentUser().then((userId) {
          Firestore.instance
              .collection('users')
              .document(userId)
              .updateData({"location": _location});
        });
      } catch (e) {
        //error
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Title"),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'location',
              ),
              onSaved: (value) => _location = value,
            ),
            RaisedButton(
                child: Text('Done!'),
                onPressed: () => {
                      validateAndSubmit(),
                    })
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
