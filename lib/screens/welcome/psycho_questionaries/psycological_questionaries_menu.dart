import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/widgets/ui_components/psyco_question.dart';

import 'dart:io';

import 'package:igea_app/widgets/ui_components/vote_button.dart';

class PsycoQuestionaryMenu extends StatefulWidget {
  PsycoQuestionaryMenu({Key key, @required this.flashToPage}) : super(key: key);

  final Function(int page) flashToPage;

  @override
  _PsycoQuestionaryMenuState createState() => _PsycoQuestionaryMenuState();
}

class _PsycoQuestionaryMenuState extends State<PsycoQuestionaryMenu> {
  final PageController _pageController = PageController(initialPage: 0);
  List<int> _answList = List<int>(4);
  bool _1check = false;
  bool _2check = false;
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF87C0D3),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF87C0D3),
      //   elevation: 0,
      //   title: Platform.isIOS
      //       ? GestureDetector(
      //           onTap: () {
      //             widget.flashToPage(2);
      //           },
      //           child: Container(
      //             width: media.width * 0.22,
      //             height: media.width * 0.18,
      //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      //             child: Align(
      //               alignment: Alignment.center,
      //               child: Container(
      //                 width: media.width * 0.5,
      //                 padding: EdgeInsets.all(media.width < 350 ? 5 : 8),
      //                 decoration: BoxDecoration(
      //                     color: Color(0xFF5C88C1),
      //                     borderRadius: BorderRadius.all(Radius.circular(35)),
      //                     border: Border.all(
      //                         style: BorderStyle.solid,
      //                         color: Colors.white,
      //                         width: 1.5)),
      //                 child: Center(
      //                     child: Icon(
      //                   Icons.arrow_upward,
      //                   color: Colors.white,
      //                   size: media.width * 0.09,
      //                 )),
      //               ),
      //             ),
      //           ))
      //       : Column(
      //           children: [
      //             SizedBox(
      //               height: media.height * 0.004,
      //             ),
      //             Center(
      //               child: GestureDetector(
      //                   onTap: () {
      //                     widget.flashToPage(2);
      //                   },
      //                   child: Container(
      //                     width: media.width * 0.21,
      //                     height: media.width * 0.17,
      //                     padding:
      //                         EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      //                     child: Align(
      //                       alignment: Alignment.center,
      //                       child: Container(
      //                         width: media.width * 0.5,
      //                         padding:
      //                             EdgeInsets.all(media.width < 350 ? 5 : 8),
      //                         decoration: BoxDecoration(
      //                             color: Color(0xFF5C88C1),
      //                             borderRadius:
      //                                 BorderRadius.all(Radius.circular(35)),
      //                             border: Border.all(
      //                                 style: BorderStyle.solid,
      //                                 color: Colors.white,
      //                                 width: 1.5)),
      //                         child: Center(
      //                             child: Icon(
      //                           Icons.arrow_upward,
      //                           color: Colors.white,
      //                           size: media.width * 0.09,
      //                         )),
      //                       ),
      //                     ),
      //                   )),
      //             ),
      //           ],
      //         ),
      // ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
              height: media.height * 0.05,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.symmetric(horizontal: 35),
              decoration: BoxDecoration(
                  color: Color(0xff6DAEBF),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.white,
                      width: 1.5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/icons/numbers/1.svg',
                    width: 23,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Conosciamoci meglio',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.05,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: media.height * 0.01),
            buildQuestionaryMenu(media),
          ],
        )),
      ),
    );
  }

  Widget buildQuestionaryMenu(
    Size media,
  ) {
    return Container(
      child: Column(
        children: [
          buildTestCard(
              media,
              'Questionario Locus of Control',
              'Mi serve per capire il tuo tipo di personalità',
              _1check),
          buildTestCard(
              media,
              'Questionario psicologico',
              'Con poche domande capiro\' quali sono i tuoi livelli d\'ansia e stress',
              _2check),
        ],
      ),
    );
  }

  Widget buildTestCard(
      Size media, String title, String description, bool _check) {
    return Container(
      // height: media.height * 0.022,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Color(0x22000000),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontFamily: 'Gotham',
                    color: Colors.white,
                    fontSize: media.height * 0.025),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(
            height: media.height * 0.01,
          ),
          Text(
            description,
            style: TextStyle(
                fontFamily: 'Book',
                color: Colors.white,
                height: media.height * 0.0015,
                fontSize: media.height * 0.02),
          ),
          SizedBox(
            height: media.height * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _check
                  ? SvgPicture.asset(
                      'assets/icons/check_in_circle.svg',
                      width: 30.0,
                      height: 30.0,
                    )
                  : Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: new BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
              SizedBox(
                width: media.width * 0.3,
              ),
              GestureDetector(
                onTap: () {
                  widget.flashToPage(1);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Text(
                    'Avvia',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        color: Color(0xff6DAEBF),
                        height: media.height * 0.0015,
                        fontSize: media.height * 0.025),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
