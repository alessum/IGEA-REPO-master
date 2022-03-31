import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_quiz.dart';
import 'package:igea_app/models/constants/gamification_constants.dart';
import 'package:igea_app/models/gamification/weekly_quiz.dart';
import 'package:igea_app/screens/quiz/quiz_complete_screen.dart';
import 'package:lottie/lottie.dart';
import 'flippable_question_card.dart';

import 'dart:async';

class QuizGameScreen extends StatefulWidget {
  QuizGameScreen({
    Key key,
    @required this.weeklyQuiz,
  }) : super(key: key);

  final Map<String, dynamic> weeklyQuiz;

  @override
  _QuizGameScreenState createState() => _QuizGameScreenState();
}

class _QuizGameScreenState extends State<QuizGameScreen>
    with TickerProviderStateMixin {
  QuizBloc bloc;

  final PageController _controller = PageController(initialPage: 0);
  AnimationController _timerGreenController;
  AnimationController _timerRedController;

  Timer _timer;
  int _startTime = 10;
  bool _flip = false;

  String key;
  WeeklyQuiz quiz;

  _startTimer() {
    const oneSec = const Duration(milliseconds: 1000);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_startTime == 0) {
        setState(() {
          setState(() {
            _flip = true;
            _startTime = 15;
            _timerRedController.reset();
            _timerRedController.forward();
          });
          _timer.cancel();
          _startCuriosityTimer();
        });
      } else {
        setState(() {
          _startTime--;
        });
      }
    });
  }

  _startCuriosityTimer() {
    const oneSec = const Duration(milliseconds: 1000);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_startTime == 0) {
        setState(() {
          _flip = false;
          if (_controller.page < quiz.questionList.length - 1) {
            _controller.nextPage(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeInCubic);
            _startTime = 10;
            _timer.cancel();
            _timerGreenController.reset();
            _timerGreenController.forward();
            _startTimer();
          } else {
            _timer.cancel();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => QuizCompleteScreen()));
          }
        });
      } else {
        setState(() {
          _startTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    key = widget.weeklyQuiz.keys.elementAt(0);
    quiz = widget.weeklyQuiz[key];
    _timerGreenController = AnimationController(vsync: this);
    _timerRedController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = QuizBlocProvider.of(context);

    return Scaffold(
      backgroundColor: Color(0xFF4373B1),
      body: Container(
        color: Color(0xFF4373B1),
        height: media.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    30.0, media.height < 750 ? 20.00 : 50.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'assets/icons/circle_left.svg',
                          width: media.width * 0.095,
                        )),
                    SizedBox(width: media.width * 0.06),
                    Text('Il Quiz',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: media.width * 0.08,
                            color: Colors.white,
                            fontFamily: 'Gotham'))
                  ],
                ),
              ),
            ),
            SizedBox(
                height: media.height *
                    0.02), //qua al posto della SizedBox mettere contatore domande

            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.transparent,
                width: media.width,
                height: media.height * 0.75,
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: quiz.questionList.length,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    print('[QUESTION LIST]: ' +
                        quiz.questionList[index].toString());
                    print(
                        '[ITEM COUNT]: ' + quiz.questionList.length.toString());
                    return Container(
                      color: Colors.transparent,
                      width: media.width * 0.9,
                      child: FlippableQuestionCard(
                        question: quiz.questionList[index],
                        questionNumber: (index + 1).toString(),
                        updateWeeklyQuiz: (value) {
                          print('generic answer pressed');
                          if (value) {
                            quiz.correctAnswersCount =
                                (quiz.correctAnswersCount ?? 0) + 1;
                            Map<String, dynamic> data = {
                              GamificationConstants.FIRESTORE_DOCUMENT_KEY: key,
                              GamificationConstants.WEEKLY_QUIZ_KEY: quiz,
                            };
                            // print('[QUIZ KEY]' + key);
                            // print('[QUIZ DATA]' + quiz.toJson().toString());
                            // print('[QUIZ CORRECT COUNT] ' + quiz.correctAnswersCount.toString());
                            bloc.inWeeklyQuizUserUpdate.add(data);
                          }
                        },
                        flip: _flip,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: media.height * 0.08,
              margin: EdgeInsets.only(bottom: media.height * 0.03),
              width: 500,
              child: _flip
                  ? Lottie.asset(
                      'assets/animations/animations/timer_verde.json',
                      controller: _timerGreenController,
                      onLoaded: (composition) {
                        setState(() {
                          _timerGreenController
                            ..duration = composition.duration
                            ..forward();
                          _timerRedController.stop();
                        });
                      },
                    )
                  : Lottie.asset(
                      'assets/animations/timer_rosso.json',
                      controller: _timerRedController,
                      onLoaded: (composition) {
                        setState(() {
                          _timerRedController
                            ..duration = composition.duration
                            ..forward();
                          _timerGreenController.stop();
                        });
                      },
                    ),
            ),
            // Container(
            //   child: Center(
            //     child: Text(
            //       '$_startTime',
            //       style: TextStyle(
            //         fontFamily: 'Gotham',
            //         fontSize: media.width * 0.08,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
