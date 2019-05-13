import 'package:flutter/material.dart';
import 'auth.dart';
import 'calendar.dart';
import 'chatbot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  initState() {
    super.initState();

    getUserInfo().then((userDetails) => {
          setState(() {
            _name = userDetails["name"];
            _dob = userDetails["dob"];
            _location = userDetails["location"];
          })
        });
  }

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Future getUserInfo() async {
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Title"),
          content: Text("content"),
          actions: <Widget>[
            FlatButton(
              child: Text("close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
        ),
        drawer: SizedBox(
          width: 200,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  height: 108,
                  child: DrawerHeader(
                      child: Text(_name != null ? _name : 'Profile',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      decoration: BoxDecoration(color: Colors.pink)),
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
                            _showDialog();
                          },
                        ))
                      ],
                    )),
                ListTile(
                    title: Text("Location:"),
                    subtitle: Text(_location != null ? _location : 'Earth'),
                    trailing: Column(
                      children: <Widget>[
                        Container(
                            child: IconButton(
                          icon: Icon(const IconData(59576,
                              fontFamily: 'MaterialIcons')),
                          onPressed: () {
                            _showDialog();
                          },
                        ))
                      ],
                    )),
                ListTile(
                  title: Text("Logout"),
                  onTap: () {
                    _signOut();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
        body: Container(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            padding: const EdgeInsets.all(3.0),
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            children: <Widget>[
              GridTile(
                child: IconButton(
                  icon:
                      Icon(const IconData(59701, fontFamily: 'MaterialIcons')),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalendarPage()),
                    );
                  },
                ),
              ),
              GridTile(
                child: Icon(const IconData(58902,
                    fontFamily: 'MaterialIcons', matchTextDirection: true)),
              ),
              GridTile(
                child: Icon(const IconData(57936, fontFamily: 'MaterialIcons')),
              ),
              GridTile(
                child: Icon(const IconData(59517, fontFamily: 'MaterialIcons')),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(const IconData(57527, fontFamily: 'MaterialIcons')),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Chatbot()));
            },
            backgroundColor: Colors.pink));
  }
}
