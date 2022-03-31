import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CustomExpansionTileFilter extends StatefulWidget {
  final Function(String) returnType;
  final Function(int) returnFromYear;
  final Function(int) returnToYear;

  CustomExpansionTileFilter(
      {this.returnType, this.returnFromYear, this.returnToYear});

  @override
  _CustomExpansionTileFilterState createState() =>
      _CustomExpansionTileFilterState();
}

class _CustomExpansionTileFilterState extends State<CustomExpansionTileFilter>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _expandAnimation;
  Animation<double> _rotateAnimation;
  bool _expand = true;

  DateTime fromDate;
  TextEditingController fromDateController = TextEditingController();
  DateTime toDate;
  TextEditingController toDateController = TextEditingController();

  @override
  void initState() {
    _dropdownMenuTestNames = buildDropdownMenuTestNames(_testNames);
    super.initState();
    prepareAnimations();
    _runExpandCheck();
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

  onChangeDropdownTest(String testName) {
    setState(() {
      _selectedTestName = testName;
    });
  }

  //FIXME USARE IL DROPDOWN COME NEL CALENDARIO CON IL DICTIONARY COSTANTE
  List<String> _testNames = [
    'Pap test',
    'HPV DNA',
    'Mammografia',
    'SOF',
    'Esame del sangue',
    'Eco color doppler dei\ntronchi sovraortici',
    'Visita cardiologica',
  ];
  List<DropdownMenuItem<String>> _dropdownMenuTestNames;
  String _selectedTestName;

  List<DropdownMenuItem<String>> buildDropdownMenuTestNames(List testNames) {
    List<DropdownMenuItem<String>> items = List();
    for (String testName in testNames) {
      items.add(
        DropdownMenuItem(value: testName, child: Text(testName)),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      height: media.height * 0.31,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: _expandAnimation,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFEDEDED),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Tipologia: ',
                                  style: TextStyle(
                                      fontFamily: 'Book',
                                      fontSize: media.width * 0.05,
                                      color: Color(0xFF757575))),
                              DropdownButton(
                                  hint: Text('non selezionata',
                                      style: TextStyle(
                                          fontFamily: 'Book',
                                          fontSize: media.width * 0.045,
                                          color: Colors.grey[500])),
                                  value: _selectedTestName,
                                  items: _dropdownMenuTestNames,
                                  onChanged: onChangeDropdownTest)
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Anno da: ',
                                  style: TextStyle(
                                      fontFamily: 'Book',
                                      fontSize: media.width * 0.05,
                                      color: Color(0xFF757575))),
                              SizedBox(
                                width: media.width * 0.09,
                                child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: '****',
                                        hintStyle: TextStyle(
                                            fontFamily: 'Book', fontSize: 17)),
                                    readOnly: true,
                                    controller: fromDateController,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDatePickerMode:
                                                  DatePickerMode.year,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                return Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    primaryColor:
                                                        const Color(0xff4768b7),
                                                    accentColor:
                                                        const Color(0xff4768b7),
                                                    colorScheme:
                                                        ColorScheme.light(
                                                            primary: const Color(
                                                                0xff4768b7)),
                                                    buttonTheme:
                                                        ButtonThemeData(
                                                            textTheme:
                                                                ButtonTextTheme
                                                                    .primary),
                                                  ),
                                                  child: child,
                                                );
                                              },
                                              lastDate: DateTime.now())
                                          .then((date) {
                                        setState(() {
                                          fromDate = date;
                                          fromDateController.text =
                                              DateFormat.y().format(fromDate);
                                        });
                                      });
                                    }),
                              ),
                              Text('a: ',
                                  style: TextStyle(
                                      fontFamily: 'Book',
                                      fontSize: media.width * 0.05,
                                      color: Color(0xFF757575))),
                              SizedBox(
                                width: media.width * 0.09,
                                child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: '****',
                                        hintStyle: TextStyle(
                                            fontFamily: 'Book', fontSize: 17)),
                                    readOnly: true,
                                    controller: toDateController,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDatePickerMode:
                                                  DatePickerMode.year,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                return Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    primaryColor:
                                                        const Color(0xff4768b7),
                                                    accentColor:
                                                        const Color(0xff4768b7),
                                                    colorScheme:
                                                        ColorScheme.light(
                                                            primary: const Color(
                                                                0xff4768b7)),
                                                    buttonTheme:
                                                        ButtonThemeData(
                                                            textTheme:
                                                                ButtonTextTheme
                                                                    .primary),
                                                  ),
                                                  child: child,
                                                );
                                              },
                                              lastDate: DateTime.now())
                                          .then((date) {
                                        setState(() {
                                          toDate = date;
                                          toDateController.text =
                                              DateFormat.y().format(toDate);
                                        });
                                      });
                                    }),
                              )
                            ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            elevation: 0.0,
                            onPressed: () {
                              fromDateController.clear();
                              toDateController.clear();
                              setState(() {
                                _selectedTestName = null;
                                fromDate = null;
                                toDate = null;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  media.width * 0.055),
                            ),
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff4768b7),
                                borderRadius:
                                    BorderRadius.circular(media.width * 0.055),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 15.0,
                                  right: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Resetta',
                                      style: TextStyle(
                                          fontSize: media.height * 0.023,
                                          color: Colors.white,
                                          fontFamily: 'Bold')),
                                  SizedBox(width: media.width * 0.05),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15.0,
                                    child: SvgPicture.asset(
                                      'assets/icons/reset.svg',
                                      width: media.width * 0.05,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: media.width * 0.06),
                          RaisedButton(
                            elevation: 0.0,
                            onPressed: () {
                              _selectedTestName == null
                                  ? widget.returnType('unspecified')
                                  : widget.returnType(_selectedTestName);
                              fromDate == null
                                  ? widget.returnFromYear(1000)
                                  : widget.returnFromYear(fromDate.year);
                              toDate == null
                                  ? widget.returnToYear(4000)
                                  : widget.returnToYear(toDate.year);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff4768b7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 15.0,
                                  right: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Cerca',
                                      style: TextStyle(
                                          fontSize: media.height * 0.023,
                                          color: Colors.white,
                                          fontFamily: 'Bold')),
                                  SizedBox(width: 10.0),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15.0,
                                    child: SvgPicture.asset(
                                      'assets/icons/search.svg',
                                      width: media.width * 0.045,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                print('[expand] ' + _expand.toString());
                _expand = !_expand;
              });
              _runExpandCheck();
            },
            child: Container(
              height: media.height < 600 ? 35 : 40,
              decoration: BoxDecoration(
                color: Color(0xff4768b7),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Cerca esame',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print('[expand] ' + _expand.toString());
                            _expand = !_expand;
                          });
                          _runExpandCheck();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff142c85)),
                          child: Transform.rotate(
                              angle: _rotateAnimation.value,
                              child: Icon(Icons.expand_more,
                                  color: Color(0xff4768b7))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
