import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodOverTime extends StatefulWidget {
  @override
  _MoodOverTimeState createState() => _MoodOverTimeState();
}

Future<String> getCurrentUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user.uid;
}

class MoodLine {
  final String date;
  final int mood;
  final charts.Color color;

  MoodLine(this.date, this.mood, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _MoodOverTimeState extends State<MoodOverTime> {
  List<MoodLine> moodData = [];
  List<MoodLine> listSlice;

  List colours = [
    Colors.blue,
    Colors.red[700],
    Colors.orange[700],
    Colors.yellow[700],
    Colors.lime,
    Colors.green
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('users')
            .document('Zcqa8zm0QfVwWuWeER1Ba0yZ1FR2')
            .collection('history')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              snapshot.data.documents.forEach((ds) => moodData.add(
                    MoodLine(ds.documentID, ds.data['emoji'],
                        colours[ds.data['emoji']]),
                  ));

              var series = [
                new charts.Series<MoodLine, String>(
                  domainFn: (MoodLine clickData, _) => clickData.date,
                  measureFn: (MoodLine clickData, _) => clickData.mood,
                  colorFn: (MoodLine clickData, _) => clickData.color,
                  id: 'Clicks',
                  data: listSlice == null ? moodData : listSlice,
                ),
              ];

              var chart = charts.BarChart(
                series,
                animate: true,
                domainAxis: new charts.OrdinalAxisSpec(
                    renderSpec: new charts.SmallTickRendererSpec(
                        minimumPaddingBetweenLabelsPx: 0,
                        labelAnchor: charts.TickLabelAnchor.before,
                        labelStyle: new charts.TextStyleSpec(
                            fontSize: 8, // size in Pts.
                            color: charts.MaterialPalette.black),
                        lineStyle: new charts.LineStyleSpec(
                            color: charts.MaterialPalette.black))),
              );

              var chartWidget = new Padding(
                padding: new EdgeInsets.all(32.0),
                child: new SizedBox(
                  height: 200.0,
                  child: chart,
                ),
              );
              return Scaffold(
                  appBar: AppBar(
                    title: Text('My Charts'),
                  ),
                  body: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('My Mood Over Time'),
                          Expanded(child: chartWidget),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () => {
                                      setState(() {
                                        listSlice = moodData.sublist(0, 7);
                                      })
                                    },
                                child: Text('7'),
                              ),
                              RaisedButton(
                                onPressed: () => {
                                      setState(() {
                                        listSlice = moodData.sublist(0, 30);
                                      })
                                    },
                                child: Text('30'),
                              ),
                              RaisedButton(
                                onPressed: () => {
                                      setState(() {
                                        listSlice = moodData;
                                      })
                                    },
                                child: Text('All'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
          }
        });
  }
}
