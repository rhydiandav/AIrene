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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.5, 0.7, 0.9],
        colors: [
          Colors.grey[100],
          Colors.grey[200],
          Colors.grey[300],
          Colors.grey[400],
        ],
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Resources'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(
                            children: <Widget>[
                              Text("Emergency:",
                                  style: Theme.of(context).textTheme.title,
                                  textScaleFactor: .7),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                        child: Text("Samaritans"),
                                        onPressed: () {
                                          launchURL(
                                              'https://www.samaritans.org/');
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
                                  launchURL(
                                      'https://www.nhs.uk/conditions/suicide/');
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(children: <Widget>[
                            Text("Mental Health:",
                                style: Theme.of(context).textTheme.title,
                                textScaleFactor: .7),
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
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text("Wellbeing:",
                                      style: Theme.of(context).textTheme.title,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .7),
                                  FlatButton(
                                    child: Text("NHS: Mindfulness"),
                                    onPressed: () {
                                      launchURL(
                                          'https://www.nhs.uk/conditions/stress-anxiety-depression/mindfulness/');
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                        "Mindful: Getting Started with Mindfulness"),
                                    onPressed: () {
                                      launchURL(
                                          'https://www.mindful.org/meditation/mindfulness-getting-started/');
                                    },
                                  ),
                                ]),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
