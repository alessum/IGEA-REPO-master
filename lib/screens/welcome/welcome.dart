import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/widgets/ui_components/button_rounded_confirmation.dart';

import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  Welcome({
    Key key,
    @required this.flashToPage,
  }) : super(key: key);

  final Function(int page) flashToPage;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this)
        // ..value = 0.5
        // ..addListener(() {
        //   setState(() {
        //     // Rebuild the widget at each frame to update the "progress" label.
        //   });
        // })
        ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    // _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Material(
      child: Container(
        color: Color(0xFFF5F5F5),
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Material(
              child: Container(
                padding: EdgeInsets.fromLTRB(media.width * 0.07,
                    media.height * 0.03, 0, media.height * 0.015),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          bottom: media.height * 0.015,
                          right: media.width * 0.07),
                      child: RichText(
                        text: TextSpan(
                          text: 'Ciao sono\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Gotham',
                            fontSize: media.width * 0.07,
                            height: media.height * 0.002,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Arold',
                              style: TextStyle(
                                color: Color(0xFF1C5287),
                                fontFamily: 'Gotham',
                                fontSize: media.width * 0.07,
                                height: media.height * 0.0015,
                              ),
                            ),
                            TextSpan(
                              text: '!',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gotham',
                                fontSize: media.width * 0.07,
                                height: media.height * 0.0015,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                              '''il tuo Coach personale per la prevenzione!\n''',
                              style: TextStyle(
                                  fontFamily: 'Gotham',
                                  color: Colors.black,
                                  fontSize: media.width * 0.05,
                                  height: media.height * 0.002)),
                        ),
                        GestureDetector(
                          onTap: () {
                            _controller.forward(from: 0);

                            Future.delayed(const Duration(milliseconds: 1966),
                                () {
                              setState(() {
                                _controller.stop();
                              });
                            });
                          },
                          child: Lottie.asset(
                            'assets/animations/arold_lateral_animation.json',
                            width: media.width * 0.25,
                            repeat: false,
                            controller:
                                _controller, //TODO attivare questa riga dopo aver capito come farlo partire di default
                            onLoaded: (composition) {
                              setState(() {
                                // print('durata: ' +
                                //     composition.duration.toString());
                                _controller
                                  ..duration = composition.duration
                                  ..forward();
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, media.width * 0.07, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'La tua salute è la mia priorità e la migliore medicina per rimanere in salute è la Prevenzione!',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Book',
                              fontSize: media.width * 0.05,
                              height: media.height * .002,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: media.height * 0.02,
                          ),
                          Text(
                            'Ti mostrerò quanto possa essere semplice e vantaggioso prendersi cura di se stessi!',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Book',
                              fontSize: media.width * 0.05,
                              height: media.height * .002,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: media.height * 0.06,
                          ),
                          GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.ease);
                            },
                            child: ButtonRoundedConfirmation(
                              label: 'Prosegui',
                              buttonColor: ConstantsGraphics.COLOR_DIARY_BLUE,
                              buttonWidth: media.width * 0.4,
                              buttonHeight: media.height * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xFFF5F5F5),
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          height: media.height * .02,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Troverai delle',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Book',
                                fontSize: media.width * 0.05,
                                height: media.height * .002,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.03,
                            ),
                            SvgPicture.asset(
                              'assets/icons/info_white.svg',
                              width: media.width * .06,
                              color: Colors.black,
                            )
                          ],
                        ),
                        Text(
                          'cliccaci per avere più informazioni',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Book',
                            fontSize: media.width * 0.05,
                            height: media.height * .002,
//                            fontSize: media.width * 0.0750,
//                            height: media.height * 0.002),
                            //                      children: <TextSpan>[
                            //                      TextSpan(
                            //                      text: 'premi la freccia verso destra',
                            //                    style: TextStyle(
                            //                      fontFamily: 'Gotham',
                            //                    color: Colors.grey,
                            //                  fontSize: media.width * 0.050,
                            //                height: media.height * 0.002),
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset("assets/avatars/arold_extended.svg",
                        height: media.height * .35),
                    Text(
                      'In ogni momento potrai\n chiedere a me e cercherò di aiutarti',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Book',
                        fontSize: media.width * 0.05,
                        height: media.height * .002,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Sono ancora giovane quindi non ti arrabbiare se non lo saprò fare',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Book',
                        fontSize: media.width * 0.05,
                        height: media.height * .002,
                      ),
                      textAlign: TextAlign.center,
//                    Row(
                      //                    mainAxisAlignment: MainAxisAlignment.end,
                      //                  children: <Widget>[
                      //                  GestureDetector(
                      //                  onTap: () {
                      //                  widget.flashToPage(1);
                      //              },
                      //            child: SvgPicture.asset('assets/icons/button_right.svg',
                      //              width: media.width * 0.2),
                      //      ),
                      //  ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      SvgPicture.asset(
                        'assets/icons/line.svg',
                        height: media.width * .2,
                      ),
                      SizedBox(
                        width: media.width * .15,
                      )
                    ]),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'Cominciamo!\n',
                    //     style: TextStyle(
                    //         fontFamily: 'Gotham',
                    //         color: Colors.black,
                    //         fontSize: 22.0,
                    //         height: 1.2),
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //         text: 'premi la freccia verso destra',
                    //         style: TextStyle(
                    //             fontFamily: 'Gotham',
                    //             color: Colors.grey,
                    //             fontSize: 15.0,
                    //             height: 1.8),
                    //       ),
                    //     ],
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.flashToPage(1);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         OnboardingRegistryBlocProvider(
                            //       child: RegistryDataScreen(),
                            //     ),
                            //   ),
                            // );
                          },
                          child: ButtonRoundedConfirmation(
                            label: 'Prosegui',
                            buttonColor: ConstantsGraphics.COLOR_DIARY_BLUE,
                            buttonWidth: media.width * 0.4,
                            buttonHeight: media.height * 0.05,
                          ),
                        ),
                        SizedBox(
                          width: media.width * .09,
                        ),
                        SvgPicture.asset(
                          'assets/avatars/arold_in_circle.svg',
                          width: media.width * 0.15,
                        ),
                        SizedBox(
                          width: media.width * .075,
                        )
                      ],
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

// RaisedButton(
//                         onPressed: () {
//                           print(
//                               widget.onboardingCache.registryCache.toString());
//                           bloc.inRegistryData
//                               .add(widget.onboardingCache.registryCache);
//                           widget.scrollForward();
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(22.0),
//                           //side: BorderSide(color: Colors.white)
//                         ),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(25))),
//                           child: Text('Conferma!',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontFamily: 'Book',
//                                 fontSize: 30.0,
//                                 height: 1.5,
//                               )),
//                         )),
