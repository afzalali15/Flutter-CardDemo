import 'dart:math' as math;

import 'package:ff_card_demo/widgets/card_back.dart';
import 'package:ff_card_demo/widgets/card_front.dart';
import 'package:flutter/material.dart';

class MyCardsPage extends StatefulWidget {
  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage>
    with SingleTickerProviderStateMixin {
  double _rotationFactor = 0;
  AnimationController _flipAnimationController;
  Animation<double> _flipAnimation;
  TextEditingController _cardNumberController,
      _cardHolderNameController,
      _cardExpiryController,
      _cvvController;
  FocusNode _cvvFocusNode;
  String _cardNumber = '';
  String _cardHolderName = '';
  String _cardExpiry = '';
  String _cvvNumber = '';

  _MyCardsPageState() {
    _cardNumberController = TextEditingController();
    _cardHolderNameController = TextEditingController();
    _cardExpiryController = TextEditingController();
    _cvvController = TextEditingController();
    _cvvFocusNode = FocusNode();

    _cardNumberController.addListener(onCardNumberChange);
    _cardHolderNameController.addListener(() {
      _cardHolderName = _cardHolderNameController.text;
      setState(() {});
    });
    _cardExpiryController.addListener(() {
      _cardExpiry = _cardExpiryController.text;
      setState(() {});
    });
    _cvvController.addListener(() {
      _cvvNumber = _cvvController.text;
      setState(() {});
    });

    _cvvFocusNode.addListener(() {
      _cvvFocusNode.hasFocus
          ? _flipAnimationController.forward()
          : _flipAnimationController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _flipAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _flipAnimation =
        Tween<double>(begin: 0, end: 1).animate(_flipAnimationController)
          ..addListener(() {
            setState(() {});
          });
//    _flipAnimationController.forward();
  }

  void onCardNumberChange() {
    _cardNumber = _cardNumberController.text;
    setState(() {});
  }

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
                ..rotateY(math.pi * _flipAnimation.value),
              origin: Offset(MediaQuery.of(context).size.width / 2, 0),
              child: _flipAnimation.value < 0.5
                  ? CardFrontView(
                      cardNumber: _cardNumber,
                      cardHolderName: _cardHolderName,
                      cardExpiry: _cardExpiry,
                    )
                  : CardBackView(
                      cvvNumber: _cvvNumber,
                    ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
//                      Slider(
//                        onChanged: (double value) {
//                          setState(() {
//                            _rotationFactor = value;
//                          });
//                        },
//                        value: _rotationFactor,
//                      ),
                      TextField(
                        controller: _cardNumberController,
                        maxLength: 16,
                        decoration: InputDecoration(
                          hintText: 'Card Number',
                        ),
                      ),
                      TextField(
                        controller: _cardHolderNameController,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _cardExpiryController,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              focusNode: _cvvFocusNode,
                              controller: _cvvController,
                              maxLength: 3,
                              decoration: InputDecoration(
                                  counterText: '', hintText: 'CVV'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
