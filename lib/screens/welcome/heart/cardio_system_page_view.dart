import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/blocs/bloc_onboarding.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_chatbot_messages.dart';
import 'package:igea_app/models/enums/ethnicity.dart';
import 'package:igea_app/screens/welcome/onboarding_page_view.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/widgets/ui_components/button_rounded_confirmation.dart';
import 'package:igea_app/widgets/ui_components/form_field_radio_button_row.dart';
import 'package:igea_app/widgets/ui_components/form_field_radio_container.dart';
import 'package:igea_app/widgets/ui_components/form_field_text_fixed_value_row.dart';
import 'package:igea_app/widgets/ui_components/form_field_text_row.dart';

class CarsioSystemPageView extends StatefulWidget {
  CarsioSystemPageView({
    Key key,
    @required this.mainPageController,
    @required this.onboardingCache,
    @required this.flashToPage,
  }) : super(key: key);

  final OnboardingCache onboardingCache;
  final PageController mainPageController;
  final Function(int page) flashToPage;

  @override
  _CarsioSystemPageViewState createState() => _CarsioSystemPageViewState();
}

class _CarsioSystemPageViewState extends State<CarsioSystemPageView> {
  OnboardingBloc bloc;
  PageController _pageController = PageController(initialPage: 0);
  PageController _examRequestPageController = PageController(initialPage: 0);
  TextEditingController controller = TextEditingController();

  bool _chkRaceAfroAmerican;
  bool _chkRaceOther;
  bool _visitAnswer = false;

  double _cholesterolTot;
  double _cholesterolHdl;
  double _systolicPressure;
  double _diastolicPressure;

  bool _chkTreatedBloodPressure = false;
  bool _chkDiabetes = false;
  bool _chkSmoker = false;

  double _height;
  double _weight;
  double _bmi;

  double _cvRisk;

  int _yearLastCardioVisit;
  int _yearLastEcoTsaVisit;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingBlocProvider.of(context);

    return Scaffold(
        backgroundColor: Color(0xFFE8B21C),
        appBar: AppBar(
            backgroundColor: Color(0xFFE8B21C),
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                // if (_pageController.page == 0) {
                //   print('PINGU');
                //   widget.flashToPage(2);
                // } else {
                //   _pageController.previousPage(
                //       duration: Duration(milliseconds: 1000),
                //       curve: Curves.ease);
                // }
                widget.flashToPage(2);
              },
              child: Container(
                width: media.width * 0.2,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Icon(
                    Icons.arrow_back,
                    size: media.width * 0.08,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
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
                          'assets/icons/numbers/5.svg',
                          width: 23,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sistema Cardiovascolare',
                          style: TextStyle(
                              fontFamily: 'Gotham',
                              fontSize: media.width * 0.05,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: media.height * 0.01),
                  Container(
                    height: media.height * 0.8,
                    child: PageView(
                      scrollDirection: Axis.vertical,
                      controller: _pageController,
                      children: [
                        _buildInputQuestionaryPage(media),
                        _buildAtRiskResultPage(media),
                        // _buildToBeImprovedLifeStyleResultPage(media),
                        // _buildGoodLifeStyleResultPage(media),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => showChat(context,
                ConstantsChatbotMessages.ONBOARDING_BREAST_MESSAGES, null),
            child: SvgPicture.asset(
              'assets/avatars/arold_in_circle.svg',
              height: 60,
            )));
  }

  Widget _buildInputQuestionaryPage(Size media) {
    return SingleChildScrollView(
      child: Container(
        // padding: EdgeInsets.only(bottom: media.height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: media.height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: media.height * 0.15,
                      width: media.width,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFFE5D4A8),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: media.height * 0.05,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: media.width * 0.7,
                            decoration: BoxDecoration(
                                color: Color.alphaBlend(
                                    Color(0xFFD8A31E), Color(0xFFE8B21C)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.white,
                                    width: 1.5)),
                            child: Row(
                              //TODO REFACTOR IN FORM_FIELD_RADIO_CONTAINER
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Etnia',
                                  style: TextStyle(
                                      fontFamily: 'Book',
                                      fontSize: media.width * 0.05,
                                      color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showChat(
                                        context,
                                        ConstantsChatbotMessages
                                            .ONBOARDING_BREAST_INFO_FAMILIARITY_MESSAGES,
                                        'Cosa si intende per familiarità?');
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/info.svg',
                                    width: media.width * 0.06,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: media.height * 0.01),
                          FormFieldRadioContainerRow(
                              label1: 'Afro Americana',
                              label2: 'Altra etnia',
                              setCheckedValue: (value1, value2) => {
                                    setState(() {
                                      _chkRaceAfroAmerican = value1;
                                      _chkRaceOther = value2;
                                    })
                                  })
                        ],
                      ),
                    ),
                    SizedBox(height: media.height * 0.01),
                    Form(
                      child: Container(
                        height: media.height * 0.5,
                        width: media.width,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFFE5D4A8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: media.height * 0.05,
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(left: 10),
                              width: media.width * 0.7,
                              decoration: BoxDecoration(
                                  color: Color.alphaBlend(
                                      Color(0xFFD8A31E), Color(0xFFE8B21C)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 1.5)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Valori del sangue',
                                  style: TextStyle(
                                      fontFamily: 'Book',
                                      fontSize: media.width * 0.05,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: media.height * 0.03),
                            // _buildRowInputElement(media,
                            //     'Colesterolo tot. (mg/dL)', '130-320'),
                            FormFieldTextRow(
                              label: Text(
                                'Colesterolo tot. (mg/dL)',
                                style: TextStyle(
                                  fontSize: media.width * 0.035,
                                  fontFamily: 'Bold',
                                ),
                              ),
                              hintText: '130-320',
                              setValue: (value) => setState(() {
                                _cholesterolTot = double.parse(value);
                              }),
                            ),
                            SizedBox(height: media.height * 0.01),
                            FormFieldTextRow(
                              label: Text(
                                'Colesterolo HDL. (mg/dL)',
                                style: TextStyle(
                                  fontSize: media.width * 0.035,
                                  fontFamily: 'Bold',
                                ),
                              ),
                              hintText: '20-100',
                              setValue: (value) => setState(() {
                                _cholesterolHdl = double.parse(value);
                              }),
                            ),
                            SizedBox(height: media.height * 0.01),
                            FormFieldTextRow(
                              label: Text(
                                'Pressione sistolica (mmHg)',
                                style: TextStyle(
                                  fontSize: media.width * 0.035,
                                  fontFamily: 'Bold',
                                ),
                              ),
                              hintText: '90-200',
                              setValue: (value) => setState(() {
                                _systolicPressure = double.parse(value);
                              }),
                            ),
                            SizedBox(height: media.height * 0.01),
                            FormFieldTextRow(
                              label: Text(
                                'Pressione diastolica (mmHg)',
                                style: TextStyle(
                                  fontSize: media.width * 0.035,
                                  fontFamily: 'Bold',
                                ),
                              ),
                              hintText: '90-200',
                              setValue: (value) => setState(() {
                                _diastolicPressure = double.parse(value);
                              }),
                            ),
                            SizedBox(height: media.height * 0.03),
                            FormFieldRadioButtonRow(
                                label: 'Trattamento pressione sangue',
                                setCheckValue: (checkedValue) => setState(() {
                                      _chkTreatedBloodPressure = checkedValue;
                                    })),
                            SizedBox(height: media.height * 0.02),
                            FormFieldRadioButtonRow(
                                label: 'Diabete',
                                setCheckValue: (checkedValue) => setState(() {
                                      _chkDiabetes = checkedValue;
                                    })),
                            SizedBox(height: media.height * 0.02),
                            FormFieldRadioButtonRow(
                                label: 'Fumatore',
                                setCheckValue: (checkedValue) => setState(() {
                                      _chkSmoker = checkedValue;
                                    })),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.height * 0.01,
                    ),
                    Container(
                      height: media.height * 0.3,
                      width: media.width,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.only(bottom: media.height * 0.01),
                      decoration: BoxDecoration(
                          color: Color(0xFFE5D4A8),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: media.height * 0.05,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 10),
                            width: media.width * 0.7,
                            decoration: BoxDecoration(
                                color: Color.alphaBlend(
                                    Color(0xFFD8A31E), Color(0xFFE8B21C)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.white,
                                    width: 1.5)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Corporatura',
                                style: TextStyle(
                                    fontFamily: 'Book',
                                    fontSize: media.width * 0.05,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: media.height * 0.01),
                          FormFieldTextRow(
                            label: Text(
                              'Altezza (cm)',
                              style: TextStyle(
                                fontSize: media.width * 0.035,
                                fontFamily: 'Bold',
                              ),
                            ),
                            hintText: '',
                            setValue: (value) => setState(() {
                              _height = double.parse(value);
                            }),
                          ),
                          SizedBox(height: media.height * 0.01),
                          FormFieldTextRow(
                            label: Text(
                              'Peso (Kg)',
                              style: TextStyle(
                                fontSize: media.width * 0.035,
                                fontFamily: 'Bold',
                              ),
                            ),
                            hintText: '',
                            setValue: (value) => setState(() {
                              _weight = double.parse(value);
                            }),
                          ),
                          SizedBox(height: media.height * 0.01),
                          FormFieldTextFixedValue(
                            label: 'BMI',
                            value: _calcBmiToString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: media.height * 0.025),
            GestureDetector(
              onTap: () {
                _updateHeartData();
                _pageController.nextPage(
                    duration: Duration(milliseconds: 1000), curve: Curves.ease);
              },
              child: ButtonRoundedConfirmation(label: 'Conferma'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAtRiskResultPage(Size media) {
    _cvRisk = 25;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: media.height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Hai un rischio cardiovascolare del $_cvRisk % Sulla base di questo risultato ti consiglio di eseguire:',
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
                // onTap: () => setState(() {
                //   _checkPapTest = true;
                //   _checkHpvDnaTest = false;
                // }),
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
                            height: media.height * 0.09,
                            decoration: BoxDecoration(
                                color: Color(0xFFD8A31E),
                                // color: (() {
                                //   if (_checkPapTest != null) {
                                //     if (_checkPapTest == true) {
                                //       return Color(0xFFD8A31E);
                                //     } else {
                                //       return Color(0xFFD8B571);
                                //     }
                                //   } else {
                                //     return Color(0xFFD8B571);
                                //   }
                                // }()),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                  width: 3,
                                  // width: (() {
                                  //   if (_checkPapTest != null) {
                                  //     if (_checkPapTest == true) {
                                  //       return 3.5;
                                  //     } else {
                                  //       return 1.5;
                                  //     }
                                  //   } else {
                                  //     return 1.5;
                                  //   }
                                  // }()),
                                )),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Visita Cardiologica',
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
                        top: media.height * 0.025,
                        child: GestureDetector(
                          onTap: () {
                            showChat(
                                context,
                                ConstantsChatbotMessages
                                    .ONBOARDING_BREAST_INFO_FAMILIARITY_MESSAGES,
                                'Cos\'è il PAP-test?');
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
                            height: media.height * 0.09,
                            decoration: BoxDecoration(
                                color: Color(0xFFD8A31E),
                                // color: (() {
                                //   if (_checkHpvDnaTest != null) {
                                //     if (_checkHpvDnaTest == true) {
                                //       return Color(0xFFD8A31E);
                                //     } else {
                                //       return Color(0xFFD8B571);
                                //     }
                                //   } else {
                                //     return Color(0xFFD8B571);
                                //   }
                                // }()),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                  width: 3,
                                  // width: (() {
                                  //   if (_checkHpvDnaTest != null) {
                                  //     if (_checkHpvDnaTest == true) {
                                  //       return 3.5;
                                  //     } else {
                                  //       return 1.5;
                                  //     }
                                  //   } else {
                                  //     return 1.5;
                                  //   }
                                  // }()),
                                )),
                            child: Center(
                              child: Text(
                                'ECO TSA',
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
                        top: media.height * 0.025,
                        child: GestureDetector(
                          onTap: () {
                            showChat(
                                context,
                                ConstantsChatbotMessages
                                    .ONBOARDING_BREAST_INFO_FAMILIARITY_MESSAGES,
                                'Cos\'è l\'hpv DNA test?');
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
          // SizedBox(height: media.height * 0.03),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 35),
          //   child: Text(
          //     'Dovresti aver ricevuto la lettera di invito dalla tua Regione',
          //     style: TextStyle(
          //         fontSize: media.width * 0.05,
          //         color: Colors.white,
          //         fontFamily: 'Book'),
          //   ),
          // ),
          SizedBox(height: media.height * 0.08),
          Container(
            height: media.height * 0.4,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _examRequestPageController,
              scrollDirection: Axis.horizontal,
              children: [
                _buildVisitRequest(
                    media, 'Hai mai fatto una visita cardiologica?'),
                _buildCardioVisitResponse(media),
                _buildVisitRequest(media, 'Hai mai fatto un ECO TSA?'),
                _buildEcoTsaVisitResponse(media),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitRequest(Size media, String label) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: media.width * 0.05,
                  color: Colors.white,
                  fontFamily: 'Bold'),
            ),
          ),
          SizedBox(height: media.height * 0.03),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _visitAnswer = true;
                    });
                    _examRequestPageController.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.ease);
                  },
                  child: Container(
                    height: media.height < 700
                        ? media.height * 0.07
                        : media.height * 0.05,
                    width: media.width * 0.25,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(0xFFD8A31E),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
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
                    setState(() {
                      _visitAnswer = false;
                    });
                    _examRequestPageController.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.ease);
                  },
                  child: Container(
                    height: media.height < 700
                        ? media.height * 0.07
                        : media.height * 0.05,
                    width: media.width * 0.25,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(0xFFD8A31E),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
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
    );
  }

  Widget _buildCardioVisitResponse(Size media) {
    return _visitAnswer
        ? Column(
            children: [
              Container(
                  child: FormFieldTextRow(
                label: Text(
                  'Quando hai fatto l\'ultima visita?',
                  style: TextStyle(
                      fontSize: media.width * 0.04,
                      color: Colors.white,
                      fontFamily: 'Gotham'),
                ),
                hintText: '',
                setValue: (value) {
                  setState(() {
                    _yearLastCardioVisit = int.parse(value);
                  });
                },
              )),
              SizedBox(height: media.height * 0.02),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _examRequestPageController.nextPage(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.ease);
                  // Map<String, dynamic> heartData = Map();
                  // heartData.addAll({
                  //   Constants.ORGAN_HEART_YEAR_LAST_CARDIO_VISIT:
                  //       _yearLastCardioVisit,
                  // });
                  // bloc.inHeartData.add(heartData);
                },
                child: ButtonRoundedConfirmation(label: 'Conferma'),
              )
            ],
          )
        : Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                'Ti consiglio di parlarne con il tuo medico di base!',
                style: TextStyle(
                    fontSize: media.width * 0.05,
                    color: Colors.white,
                    fontFamily: 'Bold'),
              ),
            ),
            SizedBox(height: media.height * 0.02),
            GestureDetector(
              onTap: () {
                _examRequestPageController.nextPage(
                    duration: Duration(milliseconds: 1000), curve: Curves.ease);
                // SCRITTURA
              },
              child: ButtonRoundedConfirmation(label: 'Continua'),
            )
          ]);
  }

  Widget _buildEcoTsaVisitResponse(Size media) {
    return _visitAnswer
        ? Column(
            children: [
              Container(
                  child: FormFieldTextRow(
                label: Text(
                  'Quando hai fatto l\'ultima visita?',
                  style: TextStyle(
                      fontSize: media.width * 0.04,
                      color: Colors.white,
                      fontFamily: 'Gotham'),
                ),
                hintText: '',
                setValue: (value) {
                  setState(() {
                    _yearLastEcoTsaVisit = int.parse(value);
                  });
                },
              )),
              SizedBox(height: media.height * 0.02),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  widget.flashToPage(2);
                  // Map<String, dynamic> heartData = Map();
                  // heartData.addAll({
                  //   Constants.ORGAN_HEART_YEAR_LAST_ECO_TSA_VISIT:
                  //       _yearLastEcoTsaVisit,
                  // });
                  // bloc.inHeartData.add(heartData);
                },
                child: ButtonRoundedConfirmation(
                  label: 'Salva e continua',
                  buttonWidth: media.width * 0.5,
                ),
              )
            ],
          )
        : Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Ti consiglio di parlarne con il tuo medico di base!',
                  style: TextStyle(
                      fontSize: media.width * 0.05,
                      color: Colors.white,
                      fontFamily: 'Bold'),
                ),
              ),
              SizedBox(height: media.height * 0.02),
              GestureDetector(
                onTap: () {
                  widget.flashToPage(2);
                  // SCRITTURA
                },
                child: ButtonRoundedConfirmation(
                  label: 'Salva e continua',
                  buttonWidth: media.width * 0.5,
                ),
              )
            ],
          );
  }

  Widget _buildToBeImprovedLifeStyleResultPage(Size media) {}

  Widget _buildGoodLifeStyleResultPage(Size media) {}

  _updateHeartData() {
    Map<String, dynamic> heartData = Map();
    heartData.addAll({
      Constants.ORGAN_HEART_CHOL_TOT_KEY: _cholesterolTot,
      Constants.ORGAN_HEART_CHOL_HDL_KEY: _cholesterolHdl,
      Constants.ORGAN_HEART_SYST_PRESS_KEY: _systolicPressure,
      Constants.ORGAN_HEART_DIAST_PRESS_KEY: _diastolicPressure,
      Constants.ORGAN_HEART_TREATMENT_BLOOD_PRESS_KEY: _chkTreatedBloodPressure,
      Constants.ORGAN_HEART_DIABETES_KEY: _chkDiabetes,
      Constants.ORGAN_HEART_SMOKE_KEY: _chkSmoker,
      Constants.ORGAN_HEART_ETHNICITY_KEY: _chkRaceAfroAmerican
          ? Ethnicity.AFROAMERICANO.index
          : Ethnicity.ALTRO.index,
    });
    bloc.inHeartData.add(heartData);
  }

  String _calcBmiToString() {
    if (_height != null && _weight != null) {
      _bmi = (_weight / (pow(_height / 100, 2))).truncateToDouble();
      return _bmi.toString();
    } else
      return '';
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
