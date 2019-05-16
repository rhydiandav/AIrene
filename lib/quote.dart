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
    ,
    {
      'quote':
          'The past has no power over the present moment.',
      'author': '- Eckhart Tolle'
    }
     ,
    {
      'quote':
          'I have lived with several Zen masters -- all of them cats.',
      'author': '- Eckhart Tolle'
    }
    ,
    {
      'quote':
          "Life is what happens to you while you're busy making other plans.",
      'author': '- John Lennon'
    }
    ,
    {
      'quote':
          "Time you enjoy wasting, was not wasted.",
      'author': '- John Lennon'
    }

    ,
    {
      'quote':
          "Happiness can be found in the darkest of times, if one only remembers to turn on the light.",
      'author': '- Albus Dumbledore'
    }

    ,
    {
      'quote':
          "In my experience, worrying means you suffer twice.",
      'author': '- Newt Scamander'
    }

    ,
    {
      'quote':
          "Once you replace negative thoughts with positive ones, you’ll start having positive results.",
      'author': '- Willie Nelson'
    }


    
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final quoteIndex = random.nextInt(11);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(quotes[quoteIndex]['quote'],
              textAlign: TextAlign.center,
              style: TextStyle(

                fontFamily: 'Delius',
                  color: Colors.teal,

                  fontSize: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(quotes[quoteIndex]['author'],
                  textAlign: TextAlign.right,
                  style: TextStyle(

                      color: Colors.teal,

                      fontSize: 15)),
            ],
          )
        ]),
      ),
    );
  }
}
