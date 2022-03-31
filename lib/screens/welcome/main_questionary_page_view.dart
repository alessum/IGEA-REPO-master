import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_chatbot.dart';
import 'package:igea_app/blocs/bloc_home.dart';
import 'package:igea_app/blocs/bloc_onboarding.dart';
import 'package:igea_app/blocs/onboarding/onboarding_breast_bloc.dart';
import 'package:igea_app/blocs/onboarding/onboarding_colon_bloc.dart';
import 'package:igea_app/blocs/onboarding/onboarding_psycho_bloc.dart';
import 'package:igea_app/models/constants/constants_chatbot_messages.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/screens/home/home.dart';
import 'package:igea_app/screens/welcome/colon/onboarding_colon_screen.dart';
import 'package:igea_app/screens/welcome/limbo_screen.dart';
import 'package:igea_app/screens/welcome/psycho_questionaries/psycho_questionaries_screen.dart';
import 'package:igea_app/services/utilities.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:igea_app/widgets/ui_components/form_field_radio_container.dart';
import 'package:igea_app/blocs/onboarding/onboarding_uterus_bloc.dart';
import 'package:igea_app/screens/welcome/uterus/onboarding_uterus_screen.dart';
import 'package:igea_app/screens/welcome/breast/onboarding_breast_screen.dart';
import 'ui_components/prevengo_main_questionary_modal_info.dart';

class MainQuestionaryPageView extends StatefulWidget {
  MainQuestionaryPageView({
    Key key,
    @required this.flashToPage,
  }) : super(key: key);

  final Function(int page) flashToPage;

  @override
  _MainQuestionaryPageViewState createState() =>
      _MainQuestionaryPageViewState();
}

class _MainQuestionaryPageViewState extends State<MainQuestionaryPageView> {
  bool _checkBreastQuestionary;
  bool _checkUterusQuestionary;
  bool _checkColonQuestionary;
  bool _checkHeartQuestionary;
  bool _checkPsychoQuestionary;

  String _username;
  Gender _gender;

  final FocusScopeNode _node = FocusScopeNode();

  OnboardingBloc bloc;

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 1000), () {
              setState(() {
                bool flag = CacheManager.getValue(
                        CacheManager.flagModalMenuQuestionaries) ??
                    false;
                if (!flag) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => PrevengoMainQuestionaryModalInfo(),
                    backgroundColor: Colors.black.withOpacity(0),
                    isScrollControlled: true,
                  );
                  CacheManager.saveKV(
                      CacheManager.flagModalMenuQuestionaries, true);
                }
              });
            }));

    _loadData();
  }

  _loadData() {
    _checkBreastQuestionary =
        CacheManager.getValue(CacheManager.checkQuestionaryBreastKey) ?? false;

    _checkUterusQuestionary =
        CacheManager.getValue(CacheManager.checkQuestionaryUterusKey) ?? false;
    _checkColonQuestionary =
        CacheManager.getValue(CacheManager.checkQuestionaryColonKey) ?? false;
    _checkHeartQuestionary =
        CacheManager.getValue(CacheManager.checkQuestionaryHeartKey) ?? false;
    _checkPsychoQuestionary =
        CacheManager.getValue(CacheManager.checkQuestionaryPsychoKey) ?? false;

    _username = CacheManager.getValue(CacheManager.usernameKey) ?? '';
    _gender = CacheManager.getValue(CacheManager.genderKey);
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingBlocProvider.of(context);
    return Scaffold(
      backgroundColor: Color(0xff4373B1),
      appBar: AppBar(
          backgroundColor: Color(0xff4373B1),
          elevation: 0,
          leading: GestureDetector(
            onTap: () => widget.flashToPage(1),
            child: Container(
              width: media.width * 0.6,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SvgPicture.asset(
                'assets/icons/circle_left.svg',
                width: media.width * 0.6,
              ),
            ),
          )),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: media.width > 350 ? 35 : 30,
              ),
              child: Text(
                'Ciao $_username,',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gotham',
                  fontSize: media.height < 700 ? 18 : 26.0,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: media.width * 0.07),
            //   child: GestureDetector(
            //     // onTap: () => Navigator.push(
            //     //     context,
            //     //     MaterialPageRoute(
            //     //       builder: (context) => OnboardingPsychoBlocProvider(
            //     //         child: PsychoQuestionnariesScreen(),
            //     //       ),
            //     //     )).then((value) {
            //     //   setState(() {});
            //     // }),
            //     child: buildQuestionaryButton(
            //       media,
            //       'Conosciamoci meglio',
            //       '1',
            //       CacheManager.getValue(
            //               CacheManager.checkQuestionaryPsychoKey) ??
            //           false,
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.07),
              child: Text(
                'Vediamo insieme come impostare una buona prevenzione per:',
                style: TextStyle(
                    fontFamily: 'Bold',
                    fontSize: media.width * 0.06,
                    color: Colors.white),
              ),
            ),
            Container(
              height: media.height * 0.18,
              padding: EdgeInsets.fromLTRB(
                  media.height * 0.03, 0, media.height * 0.03, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    (() {
                      if (_gender.index == Gender.FEMALE.index) {
                        return GestureDetector(
                          onTap: () {
                            // if (!_checkBreastQuestionary) {
                            //   widget.flashToPage(3);
                            // } else {
                            //   showQuestionaryDoneAlert(context, () {
                            //     widget.flashToPage(3);
                            //   });
                            // }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OnboardingBreastBlocProvider(
                                        child: OnboardingBreastScreen(),
                                      )),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: buildQuestionaryButton(
                            media,
                            'Tumore alla mammella*',
                            '2',
                            CacheManager.getValue(
                                  CacheManager.checkQuestionaryBreastKey,
                                ) ??
                                false,
                          ),
                        );
                      } else
                        return SizedBox(
                          height: 0,
                        );
                    }()),
                    GestureDetector(
                        onTap: () {
                          // if (!_checkUterusQuestionary) {
                          //   widget.flashToPage(4);
                          // } else {
                          //   showQuestionaryDoneAlert(
                          //       context, widget.flashToPage(4));
                          // }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OnboardingUterusBlocProvider(
                                child: OnboardingUterusScreen(),
                              ),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        child: buildQuestionaryButton(
                          media,
                          _gender == Gender.FEMALE
                              ? 'Tumore all cervice uterina*'
                              : 'Vaccino anti papilloma virus*',
                          _gender == Gender.FEMALE ? '3' : '2',
                          CacheManager.getValue(
                                CacheManager.checkQuestionaryUterusKey,
                              ) ??
                              false,
                        )),

                    GestureDetector(
                        onTap: () {
                          // if (!_checkColonQuestionary) {
                          //   widget.flashToPage(5);
                          // } else {
                          //   showQuestionaryDoneAlert(
                          //       context, widget.flashToPage(5));
                          // }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnboardingColonBlocProvider(
                                child: OnboardingColonScreen(),
                              ),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        child: buildQuestionaryButton(
                          media,
                          'Tumore al colon retto*',
                          _gender == Gender.FEMALE ? '4' : '3',
                          CacheManager.getValue(
                                CacheManager.checkQuestionaryColonKey,
                              ) ??
                              false,
                        )),

                    // GestureDetector(
                    //     onTap: () {
                    //       if (!_checkHeartQuestionary) {
                    //         widget.flashToPage(6);
                    //       } else {
                    //         showQuestionaryDoneAlert(
                    //             context, widget.flashToPage(6));
                    //       }
                    //     },
                    //     child: buildQuestionaryButton(
                    //         media, 'Malattie cardiovascolari*', _gender == Gender.FEMALE ? '5' : '4')),
                  ]),
            ),
            // SizedBox(height: media.height * 0.2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '* ',
                    style: TextStyle(
                        fontFamily: 'Book',
                        fontSize: media.height > 700
                            ? media.width * 0.07
                            : media.width * 0.06,
                        color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      'Questi questionari sono necessari per il funzionamento dell\'app',
                      style: TextStyle(
                          fontFamily: 'Book',
                          fontSize: media.height > 700
                              ? media.width * 0.045
                              : media.width * 0.035,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  if (_checkBreastQuestionary &&
                      _checkColonQuestionary &&
                      _checkHeartQuestionary &&
                      _checkPsychoQuestionary &&
                      _checkUterusQuestionary) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeBlocProvider(
                            child: Home(),
                          ),
                        ));
                  } else {
                    //setto primo accesso a false
                    bloc.setFirstAccess();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeBlocProvider(
                            child: Home(),
                          ),
                        ));
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: media.width * 0.5,
                    padding: EdgeInsets.all(media.width < 350 ? 5 : 8),
                    decoration: BoxDecoration(
                        color: Color(0xFF5C88C1),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.white,
                            width: 1.5)),
                    child: Center(
                      child: Text(
                        'Vai alla Home',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Bold',
                            fontSize: media.width * 0.05),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
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
        ),
      ),
    );
  }

  void showChat(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => Chatbot(
        suggestedMessageList: ConstantsChatbotMessages.ONBOARDING_MENU_MESSAGE,
      ),
    );
  }

  void showQuestionaryDoneAlert(BuildContext context, Function flashToPage) {
    Size media = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: media.height * 0.3,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CloseLineTopModal(),
            Container(
              child: Text(
                'Questa sezione l\'hai già completata, sei sicuro di volerla modificare?',
                style: TextStyle(
                  fontSize: media.width * 0.06,
                  fontFamily: 'Book',
                ),
              ),
            ),
            FormFieldRadioContainerRow(
                label1: 'Si',
                label2: 'No',
                buttonColor: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                setCheckedValue: (yes, _) {
                  if (yes) {
                    Navigator.pop(context);
                    flashToPage();
                  } else {
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0),
    );
  }

  Widget buildQuestionaryButton(
      Size media, String title, String number, bool checkQuestionary) {
    return Container(
      height: media.height * 0.05,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Color(0xFF5C88C1),
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(
              style: BorderStyle.solid, color: Colors.white, width: 1.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          checkQuestionary == true
              ? SvgPicture.asset(
                  'assets/icons/check.svg',
                  color: Colors.green[300],
                  width: media.width * 0.06,
                )
              : SvgPicture.asset(
                  'assets/' + number + '.svg',
                  width: media.width * 0.06,
                ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Gotham',
                fontSize: media.width * 0.045,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
