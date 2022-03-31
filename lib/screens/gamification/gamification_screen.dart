import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_awards.dart';
import 'package:igea_app/blocs/bloc_gamification.dart';
import 'package:igea_app/blocs/bloc_quiz.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/constants/gamification_constants.dart';
import 'package:igea_app/models/gamification/weekly_quiz.dart';
import 'package:igea_app/screens/gamification/credits_awards_screen.dart';
import 'package:igea_app/screens/quiz/quiz_game_screen.dart';
import 'package:igea_app/screens/quiz/quiz_main_screen.dart';

class PrimaryPreventionScreen extends StatelessWidget {
  PrimaryPreventionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GamificationBlocProvider(child: GamificationContent());
  }
}

class GamificationContent extends StatefulWidget {
  GamificationContent({Key key}) : super(key: key);

  @override
  _GamificationContentState createState() => _GamificationContentState();
}

class _GamificationContentState extends State<GamificationContent> {
  GamificationBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = GamificationBlocProvider.of(context);

    bloc.fetchWeeklyQuiz();
    return Scaffold(
      body: Container(
        height: media.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: Colors.black,
                          width: media.width * 0.095,
                        )),
                    SizedBox(width: media.width * 0.06),
                    Text('Quiz e premi',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: media.width * 0.07,
                            color: Colors.black,
                            fontFamily: 'Gotham')),
                  ],
                ),
              ),
            ),
            SizedBox(height: media.height * 0.04),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: StreamBuilder<Map<String, WeeklyQuiz>>(
                        stream: bloc.weeklyQuiz,
                        builder: (context, snapshot) {
                          return GestureDetector(
                            onTap: () {
                              if (snapshot.hasData) {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         GamificationBlocProvider(
                                //             child: QuizMainScreen(
                                //       weeklyQuiz: snapshot.data,
                                //     )),
                                //   ),
                                // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizBlocProvider(
                                      child: QuizGameScreen(
                                          weeklyQuiz: snapshot.data),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF4373B1),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(80))),
                              width: media.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 30, 0.0, 0.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.videogame_asset_outlined,
                                            size: media.width * 0.1,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: media.width * 0.03),
                                          Text('I quiz',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: media.width * 0.07,
                                                  fontFamily: 'Gotham'))
                                        ],
                                      )),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 15, 15, 0.0),
                                    child: Text(
                                        'Mettiti alla prova per guadagnare punti e riscattare coupon',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Book',
                                            fontSize: media.width * 0.045)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 15.0, 0.0),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        // Container(
                                        //   child: Text('quizzone tra:',
                                        //       style: TextStyle(
                                        //           fontFamily: 'Book',
                                        //           color: Colors.white,
                                        //           fontSize: media.height < 600
                                        //               ? 13
                                        //               : 18)),
                                        // ),
                                        snapshot.hasData
                                            ? Container(
                                                width: media.width * 0.45,
                                                height: media.height * 0.05,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF2B5A8E),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                ),
                                                child: Text(
                                                  'Avvia Test Quiz', //TODO FARE IL FORMAT DELLA DATA CONSIDERANDO IL GIORNO DI INIZIO DEL QUIZ
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Book',
                                                      color: Colors.white,
                                                      fontSize:
                                                          media.height < 600
                                                              ? 13
                                                              : 18),
                                                ),
                                              )
                                            : Container(
                                                width: media.width * 0.45,
                                                height: media.height * 0.05,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF2B5A8E),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                ),
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF87C0D3),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80))),
                        width: media.width * 0.85,
                        height: media.height < 750
                            ? media.height * 0.48
                            : media.height * 0.52,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 30, 40, 0.0),
                                child: Text('Sfida Arold!',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: media.width * 0.07,
                                        fontFamily: 'Gotham'))),
                            Container(
                              padding: EdgeInsets.fromLTRB(10.0, 15, 30.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    size: media.width * 0.13,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: media.width * 0.03),
                                  Text('In fase di\nsviluppo',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: 'Book',
                                          color: Colors.white,
                                          fontSize: media.width * 0.08)),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AwardsBlocProvider(
                            child: CredistsAndAwardsScreen(),
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFE8B21C),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(80))),
                        width: media.width * 0.8,
                        height: media.height < 750
                            ? media.height * 0.1
                            : media.height * 0.2,
                        child: Container(
                          width: media.width * 0.2,
                          padding: EdgeInsets.fromLTRB(
                              media.width * 0.07, 0, 0, 0.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.emoji_events_outlined,
                                size: media.width * 0.1,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: media.width * 0.03,
                              ),
                              Text(
                                'Classifica e\npremi',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: media.height < 600 ? 23 : 27,
                                    fontFamily: 'Gotham'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
