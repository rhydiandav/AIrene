import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BirthdaySettings extends StatefulWidget {
  BirthdaySettings({this.setDetails});
  final VoidCallback setDetails;
  @override
  _BirthdaySettingsState createState() => _BirthdaySettingsState();
}

class _BirthdaySettingsState extends State<BirthdaySettings> {
  String _dateofbirth;

  final _formKey = GlobalKey<FormState>();

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

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
        getCurrentUser().then((userId) {
          Firestore.instance
              .collection('users')
              .document(userId)
              .updateData({"dob": _dateofbirth});
        });
        widget.setDetails();
        Navigator.of(context).pop();
      } catch (e) {
        //error
        print('Change Birthday Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update Your Birthday"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DateTimePickerFormField(
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),
                editable: true,
                decoration: InputDecoration(
                    labelText: 'Date of Birth', hasFloatingPlaceholder: false),
                onSaved: (dt) =>
                    _dateofbirth = dt.toIso8601String().substring(0, 10)),
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
