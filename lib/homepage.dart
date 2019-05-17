import 'package:flutter/material.dart';
import 'package:project/meditation.dart';
import 'auth.dart';
import 'calendar.dart';
import 'chatbot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'locationsettings.dart';
import 'birthdaysettings.dart';
import 'chartpage.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'emojialert.dart';
import 'quote.dart';
import 'resources.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _name;
  String _dob;
  String _location;
  String emojiPresent;

  String emoji;

  var now = DateFormat("yyyy-MM-dd").format(new DateTime.now());

  initState() {
    super.initState();
    setDetailsState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAlert();
    });
  }

  void setDetailsState() {
    getUserDetails().then((userDetails) => {
          setState(
            () {
              _name = userDetails["name"];
              _dob = userDetails["dob"];
              _location = userDetails["location"];
              emojiPresent = userDetails[
                      '${DateFormat("yyyy-MM-dd").format(new DateTime.now())}']
                  .toString();
            },
          ),
        });
  }

  void _showAlert() {
    print('');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EmojiAlert();
        });
  }

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print('sign out error: $e');
    }
  }

  Future getUserDetails() async {
    var currentUser = await widget.auth.currentUser();
    var userDetails = await Firestore.instance
        .collection('users')
        .document(currentUser)
        .get()
        .then((DocumentSnapshot ds) {
      return (ds.data);
    });
    return userDetails;
  }

  void _showDialog(setting) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return setting == 'Location'
            ? LocationSettings(setDetails: setDetailsState)
            : BirthdaySettings(setDetails: setDetailsState);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 5.0,
      ),
      drawer: SizedBox(
        width: 200,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    Container(
                      height: 108,
                      child: DrawerHeader(
                          child: Text(_name != null ? _name : 'Profile',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          decoration: BoxDecoration(color: Colors.teal[200])),
                    ),
                    ListTile(
                        title: Text("Birthday:"),
                        subtitle: Text(_dob != null ? _dob : ""),
                        trailing: Column(
                          children: <Widget>[
                            Container(
                                child: IconButton(
                              icon: Icon(const IconData(59576,
                                  fontFamily: 'MaterialIcons')),
                              onPressed: () {
                                _showDialog('Birthday');
                              },
                            ))
                          ],
                        )),
                    ListTile(
                        title: Text("Location:"),
                        subtitle:
                            Text(_location != null ? _location : 'Manchester'),
                        trailing: Column(
                          children: <Widget>[
                            Container(
                                child: IconButton(
                              icon: Icon(const IconData(59576,
                                  fontFamily: 'MaterialIcons')),
                              onPressed: () {
                                _showDialog('Location');
                              },
                            ))
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.teal[300],
                  textColor: Colors.white,
                  child: Text("Logout"),
                  onPressed: () {
                    _signOut();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.00),
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(3.0),
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      elevation: 5.0,
                      child: IconButton(
                        icon: Icon(
                            const IconData(59701, fontFamily: 'MaterialIcons')),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalendarViewApp()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      elevation: 5.0,
                      child: IconButton(
                        icon: Icon(
                            const IconData(59105, fontFamily: 'MaterialIcons')),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoodOverTime()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      elevation: 5.0,
                      child: IconButton(
                        icon: Icon(
                            const IconData(57936, fontFamily: 'MaterialIcons')),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Resources()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      elevation: 5.0,
                      child: IconButton(
                        icon: Icon(
                            const IconData(59517, fontFamily: 'MaterialIcons')),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Meditation()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Quote(),
        Image.asset("assets/hellocatbot.png")
      ]),
      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
              child: CircleAvatar(
                  radius: 30.00,
                  child: Image.asset("assets/chatavatar.png"),
                  backgroundColor: Colors.teal[200]),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Chatbot()));
              },
              backgroundColor: Colors.teal[200]),
        ),
      ),
    );
  }
}
