import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_chatbot.dart';
import 'package:igea_app/screens/welcome/ui_components/too_late_for_screening_page.dart';
import 'package:igea_app/screens/welcome/ui_components/too_soon_for_screening_page.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';

import 'breast_last_exam_input_page.dart';
import 'breast_output_info_page.dart';
import 'check_familiarity_page.dart';

class OnboardingBreastScreen extends StatefulWidget {
  OnboardingBreastScreen({Key key}) : super(key: key);

  @override
  _OnboardingBreastScreenState createState() => _OnboardingBreastScreenState();
}

class _OnboardingBreastScreenState extends State<OnboardingBreastScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  List<Widget> _myScreens;
  List<Widget> _pageViews;

  //PAGE SCROLL MECHANISM
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
      CheckFamiliarityPage(flashToPage: _flashToPage), //0
      BreastOutputInfoPage(flashToPage: _flashToPage), //1
      BreastLastExamInputPage(flashToPage: _flashToPage), //2
      TooSoonForScreeningPage(), //3
      TooLateForScreeningPage(), //4
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
    return Scaffold(
      backgroundColor: Color(0xFFE8B21C),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE8B21C),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color(0xFFD8A31E),
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(
                    style: BorderStyle.solid, color: Colors.white, width: 1.5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/numbers/2.svg',
                  width: media.width * 0.07,
                ),
                SizedBox(width: media.width * 0.13),
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
        ),
      ),
      body: Container(
        height: media.height,
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          children: _myScreens,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatbotBlocProvider(
                    child: Chatbot(
                      suggestedMessageList: [],
                    ),
                  ),
                ),
              ),
          child: SvgPicture.asset(
            'assets/avatars/arold_in_circle.svg',
            height: 60,
          )),
    );
  }
}
