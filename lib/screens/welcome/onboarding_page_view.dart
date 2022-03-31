import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_onboarding.dart';
import 'package:igea_app/blocs/bloc_questionary.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/screens/welcome/breast/breast_page_view.dart';
import 'package:igea_app/screens/welcome/heart/cardio_system_page_view.dart';
import 'package:igea_app/screens/welcome/main_questionary_page_view.dart';
import 'package:igea_app/screens/welcome/psycho_questionaries/psychological_questionaries_page_view.dart';
import 'psycho_questionaries/behaviour_1_page_view.dart';
import 'welcome.dart';
import 'registry.dart';

class OnboardingPageView extends StatefulWidget {
  @override
  _OnboardingPageViewState createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  // List<Color> slideDotsColors = [
  //   Colors.white,
  //   Color(0xff4373B1),
  //   Color(0xffE8B21C),
  //   Colors.green[200]
  // ];

  Future<bool> _onBackPressed(Size media) {
    return showModalBottomSheet(
          backgroundColor: Colors.black.withOpacity(0),
          context: context,
          builder: (ctx) => new Container(
            height: media.height * 0.3,
            padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Sei sicuro di voler uscire?',
                  style: TextStyle(
                    fontFamily: 'Bold',
                    fontSize: media.width * 0.08,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(true),
                        child: Container(
                          height: media.height < 700
                              ? media.height * 0.08
                              : media.height * 0.06,
                          width: media.width * 0.30,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                  width: 1.5)),
                          child: Center(
                            child: Text(
                              'Si',
                              style: TextStyle(
                                  fontSize: media.width * 0.05,
                                  color: Colors.white,
                                  fontFamily: 'Bold'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: media.width * 0.01),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(ctx);
                        },
                        child: Container(
                          height: media.height < 700
                              ? media.height * 0.08
                              : media.height * 0.06,
                          width: media.width * 0.30,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                  width: 1.5)),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontSize: media.width * 0.05,
                                  color: Colors.white,
                                  fontFamily: 'Bold'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return OnboardingBlocProvider(
      child: WillPopScope(
        onWillPop: () => _onBackPressed(media),
        child: OnboardingPageViewContent(),
      ),
    );
  }
}

class OnboardingCache {
  OnboardingCache() {
    _registryCache = Map();
    _screeningCache = Map();
    _cardiovascularCache = Map();
    _checkQuestionaryCache = {
      Constants.CHECK_QUESTIONARY_BREAST_KEY: false,
      Constants.CHECK_QUESTIONARY_COLON_KEY: false,
      Constants.CHECK_QUESTIONARY_UTERUS_KEY: false,
      Constants.CHECK_QUESTIONARY_HEART_KEY: false,
      Constants.CHECK_QUESTIONARY_PSYCHO_KEY: false,
    };
  }

  Map<String, dynamic> _registryCache;
  Map<String, dynamic> _screeningCache;
  Map<String, dynamic> _cardiovascularCache;
  Map<String, dynamic> _checkQuestionaryCache;

  //getter
  Map<String, dynamic> get registryCache => _registryCache;
  Map<String, dynamic> get screeningCache => _screeningCache;
  Map<String, dynamic> get cardiovascularCache => _cardiovascularCache;
  Map<String, dynamic> get checkQuestionaryCache => _checkQuestionaryCache;

  //setter
  addRegistryData(Map<String, dynamic> registryData) =>
      _registryCache.addAll(registryData);
  addScreeningData(Map<String, dynamic> screeningData) =>
      _screeningCache.addAll(screeningData);
  addCardiovascularData(Map<String, dynamic> cardiovascularData) =>
      _cardiovascularCache.addAll(cardiovascularData);
  addCheckQuestionaryData(Map<String, dynamic> checkQuestionaryData) =>
      _checkQuestionaryCache.addAll(checkQuestionaryData);
}

class OnboardingPageViewContent extends StatefulWidget {
  OnboardingPageViewContent({Key key}) : super(key: key);

  @override
  _OnboardingPageViewContentState createState() =>
      _OnboardingPageViewContentState();
}

class _OnboardingPageViewContentState extends State<OnboardingPageViewContent> {
  List<Widget> _myScreens;
  List<Widget> _pageViews;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  OnboardingCache onboardingCache = OnboardingCache();

  //userdata
  String _username;
  String _name;
  String _surname;
  DateTime _dateOfBirth;
  Gender _gender;
  String _fiscalCode;

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
      Welcome(flashToPage: _flashToPage), //page 0
      Registry(flashToPage: _flashToPage), //page 1
      MainQuestionaryPageView(flashToPage: _flashToPage), //page 2
      BreastInfoPageView(flashToPage: _flashToPage), //page 3 //page 4
      CarsioSystemPageView(
        mainPageController: _pageController,
        onboardingCache: onboardingCache,
        flashToPage: _flashToPage,
      ), //page 6

      BehaviourQuestionary1(
        flashToPage: _flashToPage,
      ), //page 8
      PsychologicalQuestionariesPageView(
        flashToPage: _flashToPage,
      ), //page 7
    ];
  }

  @override
  void initState() {
    super.initState();
    _myScreens = _createPageContent();
    _pageViews = _createPageContent();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) { ## FIREBASE_MESSAGING
    //   print('Got a message in the foregorund!');
    //   print('Message Data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification ${message.notification}');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: PageView.builder(
          itemBuilder: (context, position) => _myScreens[position],
          itemCount: _myScreens.length,
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
