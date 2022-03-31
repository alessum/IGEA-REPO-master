import 'dart:math';
import 'package:flutter/material.dart';

class CustomExpansionCardColon extends StatefulWidget {
  @override
  _CustomExpansionCardColonState createState() =>
      _CustomExpansionCardColonState();
}

class _CustomExpansionCardColonState
    extends State<CustomExpansionCardColon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _expandAnimation;
  Animation<double> _rotateAnimation;
  bool _expand = false;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
    //print('[ARCHIVE D] ' + widget.outcome.outcomeValue.toString());
  }

  ///Setting up the animation
  void prepareAnimations() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    Animation curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    _expandAnimation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    _rotateAnimation = Tween(begin: 0.0, end: pi / 2).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  void _runExpandCheck() {
    if (_expand) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print('[ARCHIVE D2] ' + widget.outcome.outcomeValue.toString());
    return Container(
        width: 320.0,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
            height: 50,
            width: 340,
            child: Card(
                elevation: 1.0,
                color: Color.fromARGB(255, 210, 210, 210),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Colon Retto',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _expand = !_expand;
                                });
                                _runExpandCheck();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 91, 164, 186)),
                                  child: Transform.rotate(
                                      angle: _rotateAnimation.value,
                                      child: Icon(Icons.expand_more,
                                          color: Color.fromARGB(
                                              255, 240, 240, 240))),
                                ),
                              )),
                        ]))),
          ),
          SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: _expandAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    height: 75,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Familiarità',
                                style: TextStyle(fontSize: 18),
                              ),
                              Checkbox(
                                  value: true,
                                  onChanged: null,
                                  activeColor:
                                      Color.fromARGB(255, 91, 164, 186)),
                            ],
                          ),
                          Icon(Icons.info,size: 30,color:Color.fromARGB(255, 91, 164, 186) ,)
                        ],
                      ),
                    )),
              ))
        ]));
  }

  void showCustomDialog(BuildContext ctx) {
    Dialog simpleDialog = Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 150,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff4768b7),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 180,
            width: 350,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    'Si informa che la data è impostata automaticamente sulla base delle linee guida ministeriali relative all\'esame in questione.',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    textAlign: TextAlign.left),
              ),
            ),
          ),
        ),
      ),
    );
    showDialog(context: ctx, builder: (ctx) => simpleDialog);
  }
}
