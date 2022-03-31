import 'dart:math';
import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_calendar.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/reservable_test.dart';

class CustomExpansionTileTipology extends StatefulWidget {
  final String leading;
  final String trailing;
  final Function(ReservableTest) returnType;

  CustomExpansionTileTipology(
      {this.leading = '', this.trailing = '', this.returnType});

  @override
  _CustomExpansionTileTipologyState createState() =>
      _CustomExpansionTileTipologyState();
}

class _CustomExpansionTileTipologyState
    extends State<CustomExpansionTileTipology>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TextEditingController _textController = new TextEditingController();
  Animation<double> _expandAnimation;
  Animation<double> _rotateAnimation;
  bool _expand = false;

  ReservableTest _selectedReservableTest;
  ReservableTest _reservableTest;

  CalendarBloc _bloc;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  @override
  void didChangeDependencies() {
    _bloc = CalendarBlocProvider.of(context);
    super.didChangeDependencies();
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

  onChangeDropdownTest(ReservableTest reservableTest) {
    setState(() {
      _selectedReservableTest = reservableTest;
    });
    if (_selectedReservableTest.type == TestType.GENERIC_TEST) {
      setState(() {
        _reservableTest = _selectedReservableTest;
        _expand = true;
      });
    } else {
      setState(() {
        _reservableTest = _selectedReservableTest;
        widget.returnType(_reservableTest);
        _textController.clear();
        _expand = false;
      });
    }
    _runExpandCheck();
  }

  List<ReservableTest> _dropdownMenuTestList;

  List<ReservableTest> buildDropdownMenuTestList() {
    List<ReservableTest> items = List();
    Constants.RESERVABLE_TEST_LIST.forEach((k, v) {
      print(v);
      items.add(v);
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    _dropdownMenuTestList = buildDropdownMenuTestList();
    Size media = MediaQuery.of(context).size;

    return Container(
        width: 200.0,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
            height: 50,
            width: 200,
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DropdownButtonHideUnderline(
                        child: DropdownButton<ReservableTest>(
                            hint: Center(child: Text('- non selezionata')),
                            value: _selectedReservableTest,
                            items: _dropdownMenuTestList
                                .map((ReservableTest item) {
                              print(item.name);
                              return DropdownMenuItem<ReservableTest>(
                                child: Text(item.name),
                                value: item,
                              );
                            }).toList(),
                            onChanged: onChangeDropdownTest,
                            selectedItemBuilder: (BuildContext context) {
                              return _dropdownMenuTestList
                                  .map<Widget>((ReservableTest reservableTest) {
                                return Center(child: Text(reservableTest.name));
                              }).toList();
                            },
                            icon: null),
                      ),
                    ]),
              ),
            ),
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: _expandAnimation,
            child: SizedBox(
              width: 200.0,
              // width: media.width * 0.3,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: 50.0,
                      width: 200.0,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      )),
                  TextField(
                    controller: _textController,
                    onChanged: (text) {
                      setState(() {
                        _reservableTest.name = text;
                      });
                      widget.returnType(_reservableTest);
                    },
                    decoration: const InputDecoration(
                        hintText: '- specificare',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15)),
                    readOnly: false,
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
