import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/diary/diary_bloc.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/screening_outcome_value.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/screens/camera/camera_screen.dart';
import 'package:igea_app/models/camera_file_manager.dart';

class CustomExpansionTileScreeningInsert extends StatefulWidget {
  final String leading;
  final String trailing;
  final String testKey;
  final String organKey;
  final TestType testType;
  final Function() updateDiary;

  CustomExpansionTileScreeningInsert({
    @required this.leading,
    @required this.trailing,
    @required this.testKey,
    @required this.organKey,
    @required this.testType,
    @required this.updateDiary,
  });

  @override
  _CustomExpansionTileScreeningInsertState createState() =>
      _CustomExpansionTileScreeningInsertState();
}

class _CustomExpansionTileScreeningInsertState
    extends State<CustomExpansionTileScreeningInsert>
    with SingleTickerProviderStateMixin {
  ScreeningOutcomeValue value;
  AnimationController _controller;
  Animation<double> _expandAnimation;
  Animation<double> _rotateAnimation;
  bool _expand = true;

  //DiaryBloc diaryBloc;
  @override
  void didChangeDependencies() {
    //diaryBloc = DiaryBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    //_runExpandCheck();
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
    _rotateAnimation = Tween(begin: pi / 2, end: 0.0).animate(curve)
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
    Size media = MediaQuery.of(context).size;

    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(.0, media.height * 0.02, 0.0, 0.0),
            child: SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: _expandAnimation,
              child: Container(
                height: media.height * 0.3,
                width: media.width * 0.9,
                padding: EdgeInsets.only(
                  top: media.height * 0.05,
                  bottom: media.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Esito: ',
                                style: TextStyle(
                                    fontFamily: 'Book',
                                    fontSize: media.width * 0.05,
                                    color: Color(0xFF757575))),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                    width: media.width * 0.3,
                                    child: Container(
                                      height: 53,
                                      width: media.width * 0.25,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            value = ScreeningOutcomeValue.NEG;
                                          });
                                        },
                                        child: Card(
                                            elevation: 0.0,
                                            color: value == null
                                                ? Color(0xFFE0E0E0)
                                                : value == ScreeningOutcomeValue.NEG
                                                    ? Color(0xFF666666)
                                                    : Color(0xFFE0E0E0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50.0),
                                                    bottomLeft:
                                                        Radius.circular(50.0))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                      'assets/icons/happy.svg',
                                                      color: value == null
                                                          ? Color(0xFF666666)
                                                          : value ==
                                                                  ScreeningOutcomeValue
                                                                      .NEG
                                                              ? Colors.white
                                                              : Color(
                                                                  0xFF666666),
                                                      width: media.width * 0.06,
                                                    ),
                                                    Text(
                                                      'nella\nnorma',
                                                      style: TextStyle(
                                                        fontSize:
                                                            media.width * 0.038,
                                                        fontFamily: 'Book',
                                                        color: value == null
                                                            ? Color(0xFF666666)
                                                            : value ==
                                                                    ScreeningOutcomeValue
                                                                        .NEG
                                                                ? Colors.white
                                                                : Color(
                                                                    0xFF666666),
                                                      ),
                                                    ),
                                                  ]),
                                            )),
                                      ),
                                    )),
                                SizedBox(
                                    width: media.width * 0.3,
                                    child: Container(
                                      height: 53,
                                      width: media.width * 0.25,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            value = ScreeningOutcomeValue.POS;
                                          });
                                        },
                                        child: Card(
                                            elevation: 0.0,
                                            color: value == null
                                                ? Color(0xFFE0E0E0)
                                                : value == ScreeningOutcomeValue.POS
                                                    ? Color(0xFF666666)
                                                    : Color(0xFFE0E0E0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(50.0),
                                                    bottomRight:
                                                        Radius.circular(50.0))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'dubbio',
                                                      style: TextStyle(
                                                        fontSize:
                                                            media.width * 0.038,
                                                        fontFamily: 'Book',
                                                        color: value == null
                                                            ? Color(0xFF666666)
                                                            : value ==
                                                                    ScreeningOutcomeValue
                                                                        .POS
                                                                ? Colors.white
                                                                : Color(
                                                                    0xFF666666),
                                                      ),
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/icons/sad.svg',
                                                      color: value == null
                                                          ? Color(0xFF666666)
                                                          : value ==
                                                                  ScreeningOutcomeValue
                                                                      .POS
                                                              ? Colors.white
                                                              : Color(
                                                                  0xFF666666),
                                                      width: media.width * 0.06,
                                                    ),
                                                  ]),
                                            )),
                                      ),
                                    ))
                              ],
                            ),
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text('Referto: ',
                            style: TextStyle(
                                fontFamily: 'Book',
                                fontSize: media.width * 0.05,
                                color: Color(0xFF757575))),
                        SizedBox(
                          width: media.width * 0.1,
                        ),
                        SizedBox(
                            width: 150,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CameraScreen()));
                                },
                                child: RichText(
                                  text: TextSpan(
                                      text: CameraFileManager.savedImage == null
                                          ? 'carica il referto'
                                          : 'referto.jpg',
                                      style: TextStyle(
                                          color: Color(0xFF1B4393),
                                          fontSize: media.width * 0.045,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'Book')),
                                ),
                              ),
                            ))
                      ],
                    ),
                    RaisedButton(
                      elevation: 0.0,
                      onPressed: () {
                        showCustomDialog(context);
                        // diaryBloc.inNewOutcome.add({
                        //   Constants.OUTCOME_VALUE_KEY: value,
                        //   Constants.TEST_ID_KEY: widget.testKey,
                        //   Constants.TEST_TYPE_KEY: TestType.SCREENING_TEST,
                        //   Constants.CAMERA_FILE_KEY:
                        //       CameraFileManager.savedImage,
                        // });
                        DateTime d = DateTime.parse("2012-02-27 00:00:00");
                        print('[PROVA DATE TIME]' + d.toIso8601String());

                        // diaryBloc.inCalcNextDateData.add({
                        //   Constants.ORGAN_KEY: widget.organKey,
                        //   Constants.LAST_TEST_DATE_KEY: widget.trailing,
                        //   Constants.TEST_TYPE_KEY: widget.testType.index,
                        // });

                        widget.updateDiary();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: media.width * 0.35,
                        height: media.height * 0.055,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            border: Border.all(
                              width: 2.0,
                              color: Color(0xff4768b7),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text('Salva esito',
                              style: TextStyle(
                                  fontSize: media.width * 0.045,
                                  color: Color(0xff4768b7),
                                  fontFamily: 'Bold')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _expand = !_expand;
              });
              _runExpandCheck();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: media.height * 0.012),
              decoration: BoxDecoration(
                color: ConstantsGraphics.COLOR_DIARY_BLUE,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: media.width * 0.4,
                    child: Text(
                      widget.leading,
                      style: TextStyle(
                        fontSize: media.width * 0.05,
                        fontFamily: 'Bold',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.trailing,
                        style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontFamily: 'Book',
                          color: Colors.white,
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 15.0, right: 5.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Color(0xff142c85)),
                      //     child: Transform.rotate(
                      //         angle: _rotateAnimation.value,
                      //         child: Icon(Icons.expand_more,
                      //             color: Color(0xff4768b7))),
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext ctx) {
    Size media = MediaQuery.of(context).size;

    Dialog simpleDialog = Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 150,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            height: media.height * 0.02,
            width: media.width * 0.2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Esito salvato!',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Gotham',
                        color: Colors.black),
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
