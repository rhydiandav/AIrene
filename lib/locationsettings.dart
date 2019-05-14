import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationSettings extends StatefulWidget {
  LocationSettings({this.setDetails});
  final VoidCallback setDetails;
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

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      try {
        getCurrentUser().then((userId) {
          Firestore.instance
              .collection('users')
              .document(userId)
              .updateData({"location": _location});
        });
        widget.setDetails();
        Navigator.of(context).pop();
      } catch (e) {
        //error
        print('Change Location Error: $e');
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
          mainAxisSize: MainAxisSize.min,
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
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
