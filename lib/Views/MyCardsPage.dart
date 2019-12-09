import 'dart:math';

import 'package:ff_card_demo/widgets/card_back.dart';
import 'package:ff_card_demo/widgets/card_front.dart';
import 'package:flutter/material.dart';

class MyCardsPage extends StatefulWidget {
  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  double _rotationFactor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cards :)'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(pi * _rotationFactor),
              origin: Offset(MediaQuery.of(context).size.width / 2, 0),
              child: _rotationFactor < 0.5 ? CardFrontView() : CardBackView(),
            ),
            Slider(
              onChanged: (double value) {
                setState(() {
                  _rotationFactor = value;
                });
              },
              value: _rotationFactor,
            ),
          ],
        ),
      ),
    );
  }
}
