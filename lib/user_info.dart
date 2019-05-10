import 'package:flutter/material.dart';
import 'auth.dart';
import 'homepage.dart';

class UserInfo extends StatefulWidget {
  UserInfo({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _filledOutDetails = false;
  String _name;
  String _dateofbirth;
  String _gender;
  List _hobbies;

  @override
  Widget build(BuildContext context) {
    switch (_filledOutDetails) {
      case false:
        return Scaffold(
          appBar: AppBar(title: Text("Details")),
          body: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'name',
                        ),
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
                          onPressed: () => setState(() {
                                _filledOutDetails = true;
                              }))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case true:
        return HomePage(
          auth: widget.auth,
          onSignedOut: widget.onSignedOut,
        );
    }
  }
}
