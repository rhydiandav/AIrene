import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LocationSettings extends StatefulWidget {
  LocationSettings({this.auth});
  final BaseAuth auth;
  @override
  _LocationSettingsState createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {
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
          print(userId);
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
      title: Text("Update Your Location"),
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
