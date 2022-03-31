import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/screens/gamification/leaderboard_screen.dart';

class QuizPageViewScreen extends StatefulWidget {
  QuizPageViewScreen({Key key}) : super(key: key);

  @override
  _QuizPageViewScreenState createState() => _QuizPageViewScreenState();
}

class _QuizPageViewScreenState extends State<QuizPageViewScreen> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

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
                    30.0, media.height < 700 ? 20.00 : 50.0, 0.0, 0.0),
                child: Text('Prevenzione\nprimaria',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: media.width * 0.08,
                        color: Colors.white,
                        fontFamily: 'Gotham')),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: media.width,
                height: media.height * 0.8,
                decoration: BoxDecoration(
                  color: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(80),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: media.height * 0.04),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SvgPicture.asset(
                                'assets/icons/circle_left.svg',
                                width: media.width * 0.09,
                              )),
                          SizedBox(width: 20),
                          Text('i Quiz',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: media.width * 0.08,
                                  color: Colors.white,
                                  fontFamily: 'Gotham'))
                        ],
                      ),
                    ),
                    Container(
                      height: media.height * 0.7,
                      padding: EdgeInsets.fromLTRB(media.width * 0.1,
                          media.height * 0.02, media.width * 0.1, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Guadagna punti per scalare la classifica e guadagnare punti',
                              style: TextStyle(
                                  height: media.height * 0.0017,
                                  color: Colors.white,
                                  fontFamily: 'Light',
                                  fontSize: media.width * 0.045),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: media.height * 0.03,
                            ),
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: '19000 ',
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: media.width * 0.07,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'crediti  ',
                                        style: TextStyle(
                                          fontFamily: 'Light',
                                          fontSize: media.width * 0.07,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LeaderBoardScreen()));
                              },
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      media.width * 0.025,
                                      media.width * 0.01,
                                      media.width * 0.02,
                                      media.width * 0.01),
                                  margin: EdgeInsets.fromLTRB(
                                      media.width * 0.1,
                                      media.width * 0.00,
                                      media.width * 0.1,
                                      media.width * 0.05),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    color: Color(0xffFfffff),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Guarda tutta la classifica',
                                        style: TextStyle(
                                            color: ConstantsGraphics
                                                .COLOR_ONBOARDING_BLUE,
                                            fontFamily: 'Book',
                                            fontSize: media.width * 0.04),
                                      ),
                                      SvgPicture.asset(
                                        'assets/icons/circle_right.svg',
                                        width: media.width * 0.04,
                                        color: ConstantsGraphics
                                            .COLOR_ONBOARDING_BLUE,
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(height: media.height * 0.04),
                            Container(
                              // padding: EdgeInsets.only(left: 60),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Quizzone',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Book',
                                        fontSize: 24),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '\nIncomincia tra:',
                                        style: TextStyle(
                                            height: media.height * 0.0017,
                                            color: Colors.white,
                                            fontFamily: 'Light',
                                            fontSize: media.width * 0.045),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(height: media.height * 0.02),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: media.width * 0.13),
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Center(
                                  child: Text(
                                'Avvia',
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color:
                                        ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                                    fontSize: media.width * 0.05),
                              )),
                            ),
                            // SizedBox(height: media.height * 0.04),
                            // Container(
                            //   padding: EdgeInsets.only(left: 60),
                            //   child: RichText(
                            //     text: TextSpan(
                            //         text: 'Quiz giornaliero',
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontFamily: 'Book',
                            //             fontSize: 24),
                            //         children: <TextSpan>[
                            //           TextSpan(
                            //             text: '\nImpara qualcosa anche oggi:',
                            //             style: TextStyle(
                            //                 height: media.height * 0.0017,
                            //                 fontFamily: 'Book',
                            //                 color: Colors.white,
                            //                 fontSize: media.width * 0.045),
                            //           )
                            //         ]),
                            //   ),
                            // // ),
                            // SizedBox(height: media.height * 0.02),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 QuizGameScreen()));
                            //   },
                            //   child: Container(
                            //     margin: EdgeInsets.symmetric(horizontal: 100),
                            //     padding: EdgeInsets.all(13),
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(30)),
                            //     ),
                            //     child: Center(
                            //         child: Text(
                            //       'Avvia ora',
                            //       style: TextStyle(
                            //           fontFamily: 'Gotham',
                            //           color: Color(0xFF4373B1),
                            //           fontSize: media.width * 0.05),
                            //     )),
                            //   ),
                            // ),
                            SizedBox(height: media.height * 0.04),
                            Container(
                              // padding: EdgeInsets.only(left: 60),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Quiz di ripasso',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Book',
                                        fontSize: 24),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '\nRiguarda i tuoi errori\ndell\'ultimo quiz:',
                                        style: TextStyle(
                                            height: media.height * 0.0017,
                                            fontFamily: 'Light',
                                            color: Colors.white,
                                            fontSize: media.width * 0.045),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(height: media.height * 0.02),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 90),
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Center(
                                  child: Text(
                                'Avvia ora',
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color:
                                        ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                                    fontSize: media.width * 0.05),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
