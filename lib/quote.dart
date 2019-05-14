import 'package:flutter/material.dart';
import 'dart:math';

class Quote extends StatelessWidget {
  final quotes = [
    {
      'quote': 'Nothing diminishes anxiety faster than action.',
      'author': 'Walter Anderson'
    },
    {'quote': 'Smile, breathe, and go slowly.', 'author': 'Thich Nhat Hanh'},
    {
      'quote':
          'You don’t have to control your thoughts. You just have to stop letting them control you.',
      'author': 'Dan Millman'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final quoteIndex = random.nextInt(2);
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.purple,
              offset: Offset(0, 0),
              blurRadius: 5,
            )
          ]),
      height: 150,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(quotes[quoteIndex]['quote'],
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Tangerine', color: Colors.white, fontSize: 30)),
        Text(quotes[quoteIndex]['author'],
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: 'Bad Script', color: Colors.white, fontSize: 15))
      ]),
    );
  }
}
