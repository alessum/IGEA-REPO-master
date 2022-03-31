import 'package:flutter/material.dart';
import 'dart:math';
import 'package:igea_app/models/gamification/question.dart';

class FlippableQuestionCard extends StatefulWidget {
  FlippableQuestionCard({
    Key key,
    @required this.question,
    @required this.questionNumber,
    @required this.updateWeeklyQuiz,
    @required this.flip,
  }) : super(key: key);

  //final String question;
  final String questionNumber;
  final Question question;
  final Function(bool isCorrect) updateWeeklyQuiz;
  final bool flip;

  @override
  _FlippableQuestionCardState createState() => _FlippableQuestionCardState();
}

class _FlippableQuestionCardState extends State<FlippableQuestionCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.flip) {
        _animationController.forward();
        // if (_animationStatus == AnimationStatus.dismissed) {
        //   _animationController.forward();
        // } else {
        //   _animationController.reverse();
        // }
      }
    });
  }

  int _answerSelected;

  Border _correctBorder = Border.all(
    color: Colors.green[300],
    width: 3,
  );
  Border _wrongBorder = Border.all(
    color: Colors.red[300],
    width: 3,
  );

  Border _getBorder(int index) {
    if (_answerSelected != null) {
      if (widget.question.answerList[index].isCorrect) return _correctBorder;
      if (_answerSelected == index) {
        if (widget.question.answerList[index].isCorrect)
          return _correctBorder;
        else
          return _wrongBorder;
      } else
        return null;
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    if (widget.flip) {
      _animationController.forward();
      // if (_animationStatus == AnimationStatus.dismissed) {
      //   _animationController.forward();
      // } else {
      //   _animationController.reverse();
      // }
    }

    return Container(
      color: Colors.transparent,
      child: Center(
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateX(pi * _animation.value),
          child: GestureDetector(
              onTap: () {},
              child: _animation.value <= 0.5
                  ? Container(
                      width: media.width * 0.9,
                      padding: EdgeInsets.fromLTRB(
                          media.width * 0.01,
                          media.height * 0.05,
                          media.width * 0.01,
                          media.height * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: media.width * 0.83,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: media.width * 0.75,
                                    margin: EdgeInsets.symmetric(
                                        vertical: media.height * 0.02),
                                    padding: EdgeInsets.symmetric(
                                        vertical: media.height * 0.02,
                                        horizontal: media.width * 0.06),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5586BC),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Text(
                                      widget.question.text,
                                      style: TextStyle(
                                          fontFamily: 'Book',
                                          color: Colors.white,
                                          fontSize: media.width * 0.045),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF2B5A8E),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Text(widget.questionNumber,
                                        style: TextStyle(
                                            fontSize: media.width * 0.05,
                                            color: Colors.white,
                                            fontFamily: 'Gotham')),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(media.width * 0.02),
                            child: Center(
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.question.answerList.length,
                                separatorBuilder: (context, _) =>
                                    SizedBox(height: media.height * 0.01),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (_answerSelected == null) {
                                        if (widget.question.answerList[index]
                                            .isCorrect) {
                                          widget.updateWeeklyQuiz(true);
                                        } else {
                                          widget.updateWeeklyQuiz(false);
                                        }
                                        setState(() {
                                          _answerSelected = index;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF5586BC),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: _getBorder(index),
                                      ),
                                      child: Text(
                                          widget
                                              .question.answerList[index].text,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Book',
                                              fontSize: media.width * 0.04)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateX(pi),
                      child: Container(
                        width: media.width * 0.9,
                        //height: media.height * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: media.height * 0.1,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Container(
                                    //   padding: EdgeInsets.symmetric(
                                    //       vertical: 7, horizontal: 12),
                                    //   decoration: BoxDecoration(
                                    //       color: Color(0xFF2B5A8E),
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(15))),
                                    //   child: Text(widget.questionNumber,
                                    //       style: TextStyle(
                                    //           fontSize: media.width * 0.06,
                                    //           color: Colors.white,
                                    //           fontFamily: 'Gotham')),
                                    // ),
                                    // SizedBox(width: media.width*0.02),
                                    Container(
                                      child: Text(
                                        'Curiosità',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: media.width * 0.07,
                                            color: Color(0xFF2B5A8E),
                                            fontFamily: 'Gotham'),
                                      ),
                                    )
                                  ]),
                            ),
                            // Container(
                            //   width: media.width * 0.8,
                            //   child: Stack(
                            //     children: [
                            //       Container(
                            //           width: media.width * 0.8,
                            //           margin: EdgeInsets.symmetric(
                            //               vertical:
                            //                   media.height < 350 ? 18 : 25,
                            //               horizontal: 15),
                            //           padding: EdgeInsets.symmetric(
                            //               vertical: media.width > 375 ? 20 : 17,
                            //               horizontal:
                            //                   media.width > 375 ? 25 : 20),
                            //           decoration: BoxDecoration(
                            //             color: Color(0xFF5586BC),
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(30)),
                            //           ),
                            //           child: Text(widget.correctAnswer,
                            //               style: TextStyle(
                            //                   fontFamily: 'Book',
                            //                   color: Colors.white,
                            //                   fontSize: media.width * 0.04))),
                            //       Positioned(
                            //         left: media.width * 0.02,
                            //         top: media.height * 0.02,
                            //         child: Container(
                            //           padding: EdgeInsets.symmetric(
                            //               vertical: 7, horizontal: 11),
                            //           decoration: BoxDecoration(
                            //               color: Color(0xFF2B5A8E),
                            //               borderRadius: BorderRadius.all(
                            //                   Radius.circular(20))),
                            //           child: Text('A',
                            //               style: TextStyle(
                            //                   fontSize: media.width * 0.04,
                            //                   color: Colors.white,
                            //                   fontFamily: 'Gotham')),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Container(
                              width: media.width * 0.9,
                              child: Stack(
                                children: [
                                  Container(
                                    width: media.width * 0.9,
                                    margin: EdgeInsets.symmetric(
                                        vertical: media.height * 0.03,
                                        horizontal: 15),
                                    padding: EdgeInsets.symmetric(
                                        vertical: media.width > 375 ? 27 : 20,
                                        horizontal:
                                            media.width > 375 ? 30 : 20),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5586BC),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Text(
                                      widget.question.curiosity,
                                      style: TextStyle(
                                          fontFamily: 'Book',
                                          color: Colors.white,
                                          fontSize: media.width * 0.05),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: media.width * 0.02),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 11),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2B5A8E),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text('lo sapevi che...',
                                          style: TextStyle(
                                              fontSize: media.width * 0.04,
                                              color: Colors.white,
                                              fontFamily: 'Gotham')),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
        ),
      ),
    );
  }
}
