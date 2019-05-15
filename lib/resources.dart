import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Resources extends StatelessWidget {
  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resources'),
        ),
        body: Container(
          child: Card(
            child: Column(
              children: <Widget>[
                Text("Resources", style: TextStyle(fontSize: 30.0)),
                Text("Emergency:", style: TextStyle(fontSize: 25.0)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                          child: Text("Samaritans"),
                          onPressed: () {
                            launchURL('https://www.samaritans.org/');
                          }),
                      FlatButton(
                        child: Text("Phone: 116 123"),
                        onPressed: () {
                          launch("tel://116123");
                        },
                      )
                    ]),
                FlatButton(
                  child: Text("NHS: Help for Suicidal Thougts"),
                  onPressed: () {
                    launchURL('https://www.nhs.uk/conditions/suicide/');
                  },
                ),
                Text("Mental Health:", style: TextStyle(fontSize: 25.0)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Mind"),
                        onPressed: () {
                          launchURL('https://www.mind.org.uk/');
                        },
                      ),
                      FlatButton(
                        child: Text("Phone: 0300 123 3393"),
                        onPressed: () {
                          launch("tel://03001233393");
                        },
                      )
                    ]),
                FlatButton(
                    child: Text("Mental Health Foundation"),
                    onPressed: () {
                      launchURL('https://www.mentalhealth.org.uk/');
                    }),
                FlatButton(
                  child: Text("NHS: Find Services Near You"),
                  onPressed: () {
                    launchURL('https://www.nhs.uk/service-search/');
                  },
                ),
                Text("Wellbeing:", style: TextStyle(fontSize: 25.0)),
                FlatButton(
                  child: Text("NHS: Mindfulness"),
                  onPressed: () {
                    launchURL(
                        'https://www.nhs.uk/conditions/stress-anxiety-depression/mindfulness/');
                  },
                ),
                FlatButton(
                  child: Text("Mindful: Getting Started with Mindfulness"),
                  onPressed: () {
                    launchURL(
                        'https://www.mindful.org/meditation/mindfulness-getting-started/');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
