import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/services/chatbot_manager.dart';
import 'package:igea_app/services/utilities.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';

class CheckSyndromePage extends StatefulWidget {
  CheckSyndromePage({
    Key key,
    @required this.flashToPage,
  }) : super(key: key);

  //final Function(bool familiarity) updateColonFamiliarity;
  final Function(int page) flashToPage;
  @override
  _CheckSyndromePageState createState() => _CheckSyndromePageState();
}

class _CheckSyndromePageState extends State<CheckSyndromePage> {
  bool _familiarity;
  List<int> _relativeAgeList;
  int _userAge;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        ChatbotManager.showBubble(
            context, ChatbotManager.onboardingColonFamiliarityBubble));
    _loadData();
  }

  _loadData() {
    DateTime userDateOfBirth = CacheManager.getValue(
      CacheManager.dateOfBirthKey,
    );
    _userAge = DateTime.now().year - userDateOfBirth.year;
    _familiarity = CacheManager.getValue(
      CacheManager.colonFamiliarityKey,
    );
    _relativeAgeList = CacheManager.getValue(CacheManager.relativeAgeList);
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: media.height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'È nota in famiglia una o più delle seguenti sindromi?',
                  style: TextStyle(
                      fontSize: media.width * 0.05,
                      color: Colors.white,
                      fontFamily: 'Bold'),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: media.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: null,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: media.width * 0.4,
                                height: media.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xFFD8A31E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 3,
                                    )),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      'Sindrome di Lynch',
                                      style: TextStyle(
                                          fontFamily: 'Gotham',
                                          color: Colors.white,
                                          fontSize: media.width * 0.04),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: media.width * 0.36,
                            top: media.height * 0.03,
                            child: GestureDetector(
                              onTap: () {
                                // showChat(
                                //     context,
                                //     ConstantsChatbotMessages
                                //         .ONBOARDING_COLON_INFO_LYNCH_SYNDROME_MESSAGES,
                                //     'Cos\'è la sindrome di Lynch?');
                              },
                              child: SvgPicture.asset(
                                'assets/icons/info.svg',
                                width: media.width * 0.06,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: media.width * 0.04,
                  ),
                  GestureDetector(
                    onTap: null,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: media.width * 0.4,
                                height: media.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xFFD8A31E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 3,
                                    )),
                                child: Center(
                                  child: Text(
                                    'Sindrome di Peutz-Jeghers',
                                    style: TextStyle(
                                        fontFamily: 'Gotham',
                                        color: Colors.white,
                                        fontSize: media.width * 0.04),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: media.width * 0.36,
                            top: media.height * 0.03,
                            child: GestureDetector(
                              onTap: () {
                                // showChat(
                                //     context,
                                //     ConstantsChatbotMessages
                                //         .ONBOARDING_COLON_INFO_PEUTZ_JEGHERS_SYNDROME_MESSAGES,
                                //     'Cos\'è la sindrome di Peutz-Jeghers?');
                              },
                              child: SvgPicture.asset(
                                'assets/icons/info.svg',
                                width: media.width * 0.06,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: media.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: null,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: media.width * 0.4,
                                height: media.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xFFD8A31E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 3,
                                    )),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      'Poliposi Adenomatosa Familiare',
                                      style: TextStyle(
                                          fontFamily: 'Gotham',
                                          color: Colors.white,
                                          fontSize: media.width * 0.04),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: media.width * 0.36,
                            top: media.height * 0.03,
                            child: GestureDetector(
                              onTap: () {
                                // showChat(
                                //     context,
                                //     ConstantsChatbotMessages
                                //         .ONBOARDING_COLON_INFO_POLIPOSI_MESSAGES,
                                //     'Cos\'è la poliposi adenomatosa familiare?');
                              },
                              child: SvgPicture.asset(
                                'assets/icons/info.svg',
                                width: media.width * 0.06,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: media.width * 0.04,
                  ),
                  GestureDetector(
                    onTap: null,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: media.width * 0.4,
                                height: media.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xFFD8A31E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 3,
                                    )),
                                child: Center(
                                  child: Text(
                                    'Sindrome di Gardner',
                                    style: TextStyle(
                                        fontFamily: 'Gotham',
                                        color: Colors.white,
                                        fontSize: media.width * 0.04),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: media.width * 0.36,
                            top: media.height * 0.03,
                            child: GestureDetector(
                              onTap: () {
                                // showChat(
                                //     context,
                                //     ConstantsChatbotMessages
                                //         .ONBOARDING_COLON_INFO_GARDNER_SYNDROME_MESSAGES,
                                //     'Cos\'è la sindrome di Gardner?');
                              },
                              child: SvgPicture.asset(
                                'assets/icons/info.svg',
                                width: media.width * 0.06,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: media.height * 0.08),
              Container(
                height: media.height * 0.2,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                widget.flashToPage(2);
                              },
                              child: Container(
                                height: media.height < 700
                                    ? media.height * 0.07
                                    : media.height * 0.05,
                                width: media.width * 0.25,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Color(0xFFD8A31E),
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
                                        fontFamily: 'Gotham'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_userAge < 50 || _userAge > 69) {
                                  widget.flashToPage(3);
                                } else {
                                  widget.flashToPage(4);
                                }
                              },
                              child: Container(
                                height: media.height < 700
                                    ? media.height * 0.07
                                    : media.height * 0.05,
                                width: media.width * 0.25,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Color(0xFFD8A31E),
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
                                        fontFamily: 'Gotham'),
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
              ),
            ],
          ),
        ));
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
}
