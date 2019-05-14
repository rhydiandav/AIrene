import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MoodOverTime extends StatefulWidget {
  @override
  _MoodOverTimeState createState() => _MoodOverTimeState();
}

class MoodLine {
  final String date;
  final int mood;
  final charts.Color color;

  MoodLine(this.date, this.mood, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _MoodOverTimeState extends State<MoodOverTime> {
  @override
  Widget build(BuildContext context) {
    var data = [
      MoodLine('2019-05-10', 5, Colors.red),
      MoodLine('2019-05-11', 2, Colors.yellow),
      MoodLine('2019-05-12', 5, Colors.green),
    ];

    var series = [
      new charts.Series(
        domainFn: (MoodLine clickData, _) => clickData.date,
        measureFn: (MoodLine clickData, _) => clickData.mood,
        colorFn: (MoodLine clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
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
          title: Text('Line Chart'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('My Charts'),
                Expanded(child: chartWidget),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => {print('im pressed')},
                      child: Icon(Icons.pie_chart),
                    ),
                    RaisedButton(
                      onPressed: () => {print('im pressed')},
                      child: Icon(Icons.access_time),
                    ),
                    RaisedButton(
                      onPressed: () => {print('im pressed')},
                      child: Icon(Icons.mood),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
