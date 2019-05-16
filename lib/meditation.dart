import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Meditation extends StatefulWidget {
  _MeditationState createState() => _MeditationState();
}

class _MeditationState extends State<Meditation>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween<double>(begin: 0, end: 280).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((state) => print('$state'));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Meditation")),
        body: AnimatedCircle(animation: animation));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedCircle extends AnimatedWidget {
  AnimatedCircle({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Column(
      children: <Widget>[
        Container(
          child: Center(
            child: Container(

//column
              margin: EdgeInsets.symmetric(vertical: 10),
              height: animation.value,
              width: animation.value,
              child: Center(
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                      color: Colors.teal[200],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal,
                          offset: Offset(0, 0),
                          blurRadius: 200,
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Text('Breath In....',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
        ),
      ],
      //child of column
    );
  }
}
