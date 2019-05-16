import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails extends StatefulWidget {
  UserDetails({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String _name;
  String _dateofbirth;
  String _gender;
  // List _hobbies;

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
          Firestore.instance.collection('users').document(userId).updateData(
              {"name": _name, "dob": _dateofbirth, "gender": _gender});
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Hello, who are you?'),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'name',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Please tell me your name!' : null,
                    onSaved: (value) => _name = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'gender',
                    ),
                    onSaved: (value) => _gender = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'date_ of birth',
                    ),
                    onSaved: (value) => _dateofbirth = value,
                  ),
                  RaisedButton(
                      child: Text('Done!'),
                      onPressed: () => {
                            validateAndSubmit(),
                          })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
