import 'package:flutter/material.dart';
import 'auth.dart';
import 'calendar.dart';
import 'chatbot.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Container(
                height: 108,
                child: DrawerHeader(
                    child: Text("Your Account",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    decoration: BoxDecoration(color: Colors.pink)),
              ),
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
