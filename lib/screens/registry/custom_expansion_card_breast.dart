import 'dart:math';
import 'package:flutter/material.dart';

class CustomExpansionCardBreast extends StatefulWidget {
  final bool familiarity;

  const CustomExpansionCardBreast({Key key, @required this.familiarity})
      : super(key: key);

  @override
  _CustomExpansionCardBreastState createState() =>
      _CustomExpansionCardBreastState();
}

class _CustomExpansionCardBreastState extends State<CustomExpansionCardBreast>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _expandAnimation;
  Animation<double> _rotateAnimation;
  bool _expand = false;

  bool _checkBoxFamiliarityValue;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
    _checkBoxFamiliarityValue = widget.familiarity;
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

  void changeFamiliarityValue(bool newValue) {
    setState(() {
      _checkBoxFamiliarityValue = newValue;
      if (_checkBoxFamiliarityValue == true) {
        //showAlertFamiliarity(this.context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            'Mammella',
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
                                  value: _checkBoxFamiliarityValue,
                                  onChanged: changeFamiliarityValue,
                                  activeColor:
                                      Color.fromARGB(255, 91, 164, 186)),
                            ],
                          ),
                          GestureDetector(
                              onTap: () => showCustomDialog(context),
                              child: Icon(
                                Icons.info,
                                size: 30,
                                color: Color.fromARGB(255, 91, 164, 186),
                              ))
                        ],
                      ),
                    )),
              ))
        ]));
  }

  void showCustomDialog(BuildContext ctx) {

    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaRatio = mediaWidth/mediaHeight;

    Dialog simpleDialog = Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: EdgeInsets.all(mediaRatio * 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Familiarità',
                  style: TextStyle(fontSize: mediaRatio * 80, fontWeight: FontWeight.w300)),
              SizedBox(height: mediaRatio * 20),
              Text(
                  'Selezionare questa casella solamente se tra i tuoi parenti di primo grado (genitori e nonni) ci sono:',
                  style: TextStyle(fontSize: mediaRatio * 36)),
              SizedBox(height: mediaRatio * 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: mediaRatio * 140,
                    width: mediaRatio * 260,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      border: Border.all(
                          color: Color.fromARGB(255, 91, 164, 186), width: 3),
                    ),
                    child: Center(
                      child:
                          Text('Almeno 3 casi', style: TextStyle(fontSize:  mediaRatio * 36)),
                    ),
                  ),
                  Text('O', style: TextStyle(fontSize: 15)),
                  Container(
                    height:  mediaRatio * 140,
                    width:  mediaRatio * 260,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      border: Border.all(
                          color: Color.fromARGB(255, 91, 164, 186), width: 3),
                    ),
                    child: Center(
                      child: Text('Almeno 2 casi di età inferiore a 50 anni',
                          style: TextStyle(fontSize:  mediaRatio * 30)),
                    ),
                  ),
                ],
              ),
              SizedBox(height:  mediaRatio * 20),
              Text('A cui sono stati diagnosticati almeno uno tra i seguenti:',
                  style: TextStyle(fontSize:  mediaRatio * 36)),
              SizedBox(height:  mediaRatio * 20),
              Padding(
                padding: EdgeInsets.only(left:  mediaRatio * 16.0),
                child: Text('- Tumore alla mammella',
                    style: TextStyle(fontSize:  mediaRatio * 36)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left:  mediaRatio * 16.0),
                child:
                    Text('- Tumore alle ovaie', style: TextStyle(fontSize:  mediaRatio * 36)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left:  mediaRatio * 16.0),
                child: Text('- Tumore al peritoneo',
                    style: TextStyle(fontSize:  mediaRatio * 36)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left:  mediaRatio * 16.0),
                child: Text('- Tumore al pancreas',
                    style: TextStyle(fontSize:  mediaRatio * 36)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left:  mediaRatio * 16.0),
                child: Text('- Tumore alla prostata',
                    style: TextStyle(fontSize:  mediaRatio * 36)),
              ),
              SizedBox(height:  mediaRatio * 80),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Color.fromARGB(255, 91, 164, 186),
                  ),
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Center(
                        child: Text(
                          'Ho Capito',
                          style: TextStyle(fontSize:  mediaRatio * 40, color: Colors.white),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
    showDialog(context: ctx, builder: (ctx) => simpleDialog);
  }

  void showAlertFamiliarity(BuildContext ctx) {
    Dialog alertFamiliarity = Dialog();
    showDialog(context: ctx, builder: (ctx) => alertFamiliarity);
  }
}
