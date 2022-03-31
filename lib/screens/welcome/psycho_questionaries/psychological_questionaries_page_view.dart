import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/screens/welcome/psycho_questionaries/psycological_questionaries_menu.dart';

import 'dart:io';
import 'behaviour_1_page_view.dart';

class PsychologicalQuestionariesPageView extends StatefulWidget {
  PsychologicalQuestionariesPageView({Key key, @required this.flashToPage})
      : super(key: key);

  final Function(int page) flashToPage;

  @override
  _PsychologicalQuestionariesPageViewState createState() =>
      _PsychologicalQuestionariesPageViewState();
}

class _PsychologicalQuestionariesPageViewState
    extends State<PsychologicalQuestionariesPageView> {
  final PageController _pageController = PageController(initialPage: 0);
  bool _1check = false;
  bool _2check = false;
  List<Widget> _myScreens;
  List<Widget> _pageViews;

  void refreshChildren(Duration duration) {
    setState(() {
      _myScreens = _createPageContent();
    });
  }

  void _swapChildren(int pageCurrent, int pageTarget) {
    List<Widget> newVisiblePageViews = [];
    newVisiblePageViews.addAll(_pageViews);
    if (pageTarget > pageCurrent) {
      newVisiblePageViews[pageCurrent + 1] = _myScreens[pageTarget];
    } else if (pageTarget < pageCurrent) {
      newVisiblePageViews[pageCurrent - 1] = _myScreens[pageTarget];
    }

    setState(() {
      _myScreens = newVisiblePageViews;
    });
  }

  Future _quickJump(int pageCurrent, int pageTarget) async {
    int quickJumpTarget;

    if (pageTarget > pageCurrent) {
      quickJumpTarget = pageCurrent + 1;
    } else if (pageTarget < pageCurrent) {
      quickJumpTarget = pageCurrent - 1;
    }
    await _pageController.animateToPage(
      quickJumpTarget,
      curve: Curves.easeIn,
      duration: Duration(seconds: 1),
    );
    _pageController.jumpToPage(pageTarget);
  }

  _flashToPage(int page) async {
    int pageCurrent = _pageController.page.round();
    int pageTarget = page;
    if (pageCurrent == pageTarget) {
      return;
    }
    _swapChildren(pageCurrent, pageTarget);
    await _quickJump(pageCurrent, pageTarget);
    WidgetsBinding.instance.addPostFrameCallback(refreshChildren);
  }

  List<Widget> _createPageContent() {
    return <Widget>[
      PsycoQuestionaryMenu(flashToPage: _flashToPage), // page 0
      BehaviourQuestionary1(flashToPage: _flashToPage), // page 1
    ];
  }

  @override
  void initState() {
    super.initState();
    _myScreens = _createPageContent();
    _pageViews = _createPageContent();
  }

  Color _upColor = Color(0xFF5C88C1);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    // PageView questionariesPageView = PageView(
    //   controller: _pageController,
    //   scrollDirection: Axis.vertical,
    //   physics: NeverScrollableScrollPhysics(),
    //   children: _myScreens,
    // );

    return Scaffold(
      backgroundColor: Color(0xFF87C0D3),
      appBar: AppBar(
        backgroundColor: Color(0xFF87C0D3),
        elevation: 0,
        title: Platform.isIOS
            ? GestureDetector(
                onTap: () {
                  (_pageController.page == 0)
                      ? widget.flashToPage(2)
                      : _flashToPage(0);
                },
                child: Container(
                  width: media.width * 0.22,
                  height: media.width * 0.18,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: media.width * 0.5,
                      padding: EdgeInsets.all(media.width < 350 ? 5 : 8),
                      decoration: BoxDecoration(
                          color: (_pageController.page == 0)
                              ? _upColor = Color(0xFF5C88C1)
                              : _upColor = Color(0xff6DAEBF),
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.white,
                              width: 1.5)),
                      child: Center(
                          child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: media.width * 0.09,
                      )),
                    ),
                  ),
                ))
            : Column(
                children: [
                  SizedBox(
                    height: media.height * 0.004,
                  ),
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          widget.flashToPage(2);
                        },
                        child: Container(
                          width: media.width * 0.21,
                          height: media.width * 0.17,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: media.width * 0.5,
                              padding:
                                  EdgeInsets.all(media.width < 350 ? 5 : 8),
                              decoration: BoxDecoration(
                                  color: Color(0xFF5C88C1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35)),
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 1.5)),
                              child: Center(
                                  child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                                size: media.width * 0.09,
                              )),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
        // leading: GestureDetector(
        //   onTap: () {
        //     // if (_pageController.page == 0) {
        //     //   print('PINGU');
        //     //   widget.flashToPage(2);
        //     // } else {
        //     //   _pageController.previousPage(
        //     //       duration: Duration(milliseconds: 1000),
        //     //       curve: Curves.ease);
        //     // }
        //     widget.flashToPage(2);
        //   },
        //   child: Container(
        //     width: media.width * 0.22,
        //     height: media.width * 0.18,
        //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        //     child: Align(
        //       alignment: Alignment.center,
        //       child: Container(
        //         width: media.width * 0.5,
        //         padding: EdgeInsets.all(media.width < 350 ? 5 : 8),
        //         decoration: BoxDecoration(
        //             color: Color(0xFF87C0D3),
        //             borderRadius: BorderRadius.all(Radius.circular(35)),
        //             border: Border.all(
        //                 style: BorderStyle.solid,
        //                 color: Colors.white,
        //                 width: 1.5)),
        //         child: Center(
        //             child: Icon(
        //           Icons.arrow_upward,
        //           color: Colors.white,
        //           size: media.width * 0.09,
        //         )),
        //       ),
        //     ),
        //   ),
        // )
      ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            SizedBox(
              height: media.height * 0.01,
            ),
            SizedBox(height: media.height * 0.01),
            Container(
              height: media.height * 0.8,
              child: PageView(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                children: _myScreens,
              ),
            )
          ],
        )),
      ),
    );
  }
}
