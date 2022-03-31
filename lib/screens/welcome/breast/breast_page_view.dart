import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_onboarding.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/screens/welcome/breast/breast_last_exam_input_page.dart';
import 'package:igea_app/screens/welcome/breast/breast_output_info_page.dart';
import 'package:igea_app/screens/welcome/breast/check_familiarity_page.dart';
import 'package:igea_app/screens/welcome/breast/familiarity_output_page.dart';
import 'package:igea_app/screens/welcome/uterus/begin_from_zero_page.dart';
import 'package:igea_app/screens/welcome/uterus/dont_remember_last_exam_page.dart';
import 'package:igea_app/screens/welcome/uterus/no_in_age_of_screening_page.dart';
import 'package:igea_app/services/utilities.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/models/constants/constants_chatbot_messages.dart';
import 'dart:async';

class BreastInfoPageView extends StatefulWidget {
  BreastInfoPageView({
    Key key,
    @required this.flashToPage,
  }) : super(key: key);

  final Function(int page) flashToPage;
  @override
  _BreastInfoPageViewState createState() => _BreastInfoPageViewState();
}

class _BreastInfoPageViewState extends State<BreastInfoPageView> {
  final PageController _pageController = PageController(initialPage: 0);

  OnboardingBloc bloc;

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
      CheckFamiliarityPage(
        flashToPage: _flashToPage,
      ),
      FamiliarityOutputPage(setQuestionaryDone: () {
        CacheManager.saveKV(
          CacheManager.checkQuestionaryBreastKey,
          true,
        );
        widget.flashToPage(2);
      }),
      BreastOutputInfoPage(
        flashToPage: _flashToPage,
      ),
      BreastLastExamInputPage(),
      NoInAgeOfScreeningPage(setQuestionaryDone: () {
        CacheManager.saveKV(
          CacheManager.checkQuestionaryBreastKey,
          true,
        );
        _updateBreastBeginFromZero();
        widget.flashToPage(2);
      }),
      BeginFromZeroPage(setQuestionaryDone: () {
        CacheManager.saveKV(
          CacheManager.checkQuestionaryBreastKey,
          true,
        );
        widget.flashToPage(2);
      }),
      DontRememberLastExamPage(setQuestionaryDone: () {
        CacheManager.saveKV(
          CacheManager.checkQuestionaryBreastKey,
          true,
        );
        widget.flashToPage(2);
      })
    ];
  }

  void initState() {
    super.initState();
    _myScreens = _createPageContent();
    _pageViews = _createPageContent();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingBlocProvider.of(context);

    return Scaffold(
      backgroundColor: Color(0xFFE8B21C),
      appBar: AppBar(
        toolbarHeight: media.height * 0.15,
        elevation: 0,
        backgroundColor: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
        title: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (_pageController.page == 0) {
                  widget.flashToPage(2);
                } else {
                  _flashToPage(0);
                }
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
                        color: Color(0xFF5C88C1),
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
              ),
            ),
            SizedBox(height: media.height * 0.01),
            Container(
              height: media.height * 0.05,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.symmetric(horizontal: 35),
              decoration: BoxDecoration(
                  color: Color(0xFFD8A31E),
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
                    'assets/icons/numbers/2.svg',
                    width: 23,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Mammella',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.05,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          children: _myScreens,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showChat(context,
              ConstantsChatbotMessages.ONBOARDING_BREAST_MESSAGES, null),
          child: SvgPicture.asset(
            'assets/avatars/arold_in_circle.svg',
            height: 60,
          )),
    );
  }

  void showChat(
      BuildContext context, List<String> suggestedMessageList, String message) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => message != null
          ? Chatbot(
              suggestedMessageList: suggestedMessageList,
              inputMessage: message,
            )
          : Chatbot(
              suggestedMessageList: suggestedMessageList,
            ),
    );
  }

  void _updateBreastLastExam(int examYear) {
    DateTime lastTestDate = DateTime(examYear);
    Map<String, dynamic> data = Map();
    Map<String, dynamic> testData = Map();

    data.addAll({
      Constants.ORGAN_KEY: Constants.BREAST_KEY,
      Constants.LAST_TEST_DATE_KEY: lastTestDate,
    });
    bloc.inUpdateOrganData.add(data);

    testData.addAll({
      Constants.TEST_NAME_KEY: 'Mammografia',
      Constants.ORGAN_KEY: Constants.BREAST_KEY,
      Constants.TEST_TYPE_KEY: TestType.MAMMOGRAPHY,
      Constants.TEST_DESCRIPTION_KEY: 'Descrizione',
      Constants.RESERVATION_DATE_KEY: lastTestDate,
    });
    bloc.inNewTestData.add(testData);

    Map<String, dynamic> algorithmData = Map();
    algorithmData.addAll({
      Constants.ORGAN_KEY: Constants.BREAST_KEY,
      Constants.LAST_TEST_DATE_KEY: lastTestDate,
      Constants.TEST_TYPE_KEY: TestType.MAMMOGRAPHY.index,
    });
    bloc.inCalcNextDateData.add(algorithmData);
  }

  void _updateBreastBeginFromZero() {
    Map<String, dynamic> data = Map();
    data.addAll({
      Constants.ORGAN_KEY: Constants.BREAST_KEY,
      Constants.LAST_TEST_DATE_KEY: null,
    });
    bloc.inUpdateOrganData.add(data);

    Map<String, dynamic> algorithmData = Map();
    algorithmData.addAll({
      Constants.ORGAN_KEY: Constants.BREAST_KEY,
      Constants.TEST_TYPE_KEY: TestType.MAMMOGRAPHY.index,
    });
    bloc.inCalcNextDateData.add(algorithmData);
  }
}
