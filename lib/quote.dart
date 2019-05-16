import 'package:flutter/material.dart';
import 'dart:math';

class Quote extends StatelessWidget {
  final quotes = [
    {
      'quote': 'Nothing diminishes anxiety faster than action.',
      'author': '- Walter Anderson'
    },
    {'quote': 'Smile, breathe, and go slowly.', 'author': '- Thich Nhat Hanh'},
    {
      'quote':
          'You don’t have to control your thoughts. You just have to stop letting them control you.',
      'author': '- Dan Millman'
    },
    {
      'quote':
          'Life is ten percent what you experience and ninety percent how you respond to it.',
      'author': '- Dorothy M. Neddermeyer'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final quoteIndex = random.nextInt(3);
    return Container(
      // margin: const EdgeInsets.all(20.0),
      // padding: const EdgeInsets.all(15.0),
      // decoration: BoxDecoration(
      //     color: Colors.purple[100],
      //     borderRadius: BorderRadius.circular(25.0),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.pink[200],
      //         offset: Offset(0, 0),
      //         blurRadius: 10,
      //       )
      //     ]),
      // height: 150,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Text(quotes[quoteIndex]['quote'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  // fontFamily: 'Tangerine',
                  color: Colors.pink,
                  fontSize: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(quotes[quoteIndex]['author'],
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      // fontFamily: 'Bad Script',
                      color: Colors.pink,
                      fontSize: 15)),
            ],
          )
        ]),
      ),
    );
  }
}
