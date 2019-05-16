import 'package:flutter/material.dart';
import 'auth.dart';

class LogIn extends StatefulWidget {
  LogIn({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LogInState();
}

enum FormType { login, register }

class _LogInState extends State<LogIn> {
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
          print(
            'Signed in: $userId',
          );
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print("Registered user: $userId");
        }
        widget.onSignedIn();
      } catch (e) {
        print('Login Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildInputs() + buildSubmitButtons(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      Image.asset("assets/welcomecatbot.png", height: 180),
      Container(
        // constraints: BoxConstraints.expand(height: 280),
        // decoration: BoxDecoration(
        //   // shape: BoxShape.circle,
        //   // color: Colors.teal[200],
        //   image: DecorationImage(
        //       image: AssetImage("assets/welcomecatbot.png"), fit: BoxFit.cover),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'AI',
                  style: TextStyle(
                      fontFamily: 'VT323',
                      fontSize: 70,
                      height: 0.8,
                      color: Colors.teal[900]),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'rene',
                  style: TextStyle(
                      fontFamily: 'Sacramento',
                      fontSize: 80,
                      height: 0.3,
                      color: Colors.teal[900]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text('your personal wellbeing bot',
                style: TextStyle(fontFamily: 'Bad Script', fontSize: 30)),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
          ),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      )
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          child: RaisedButton(
              elevation: 5.0,
              textColor: Colors.white,
              color: Colors.teal[200],
              child: Text("Login",
                  style: TextStyle(
                    fontSize: 20.0,
                  )),
              onPressed: validateAndSubmit,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        ),
        FlatButton(
          child: Text(
            "Create an account",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        Padding(
          padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          child: RaisedButton(
            elevation: 5.0,
            textColor: Colors.white,
            color: Colors.teal[200],
            child: Text(
              "Create an account",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: validateAndSubmit,
          ),
        ),
        FlatButton(
          child: Text(
            "Have an account? Login",
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
