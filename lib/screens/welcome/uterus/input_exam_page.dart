import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/onboarding/onboarding_uterus_bloc.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/screens/camera/camera_screen.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_modal_outcome_image.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_onboarding_button_icon.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_onboarding_radio_button_info.dart';
import 'package:igea_app/screens/welcome/uterus/ui_components/prevengo_radio_button_text.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class InputExamPage extends StatefulWidget {
  InputExamPage({
    Key key,
    @required this.flashToPage,
  }) : super(key: key);

  final Function(int page) flashToPage;

  @override
  _InputExamPageState createState() => _InputExamPageState();
}

class _InputExamPageState extends State<InputExamPage> {
  OnboardingUterusBloc bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => bloc.initInputExamPage());
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingUterusBlocProvider.of(context);

    return Container(
      padding:
          EdgeInsets.only(bottom: media.height * .015, top: media.height * .1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Container(
                child: Center(
                    child: Text(
                  'Che tipo di esame hai fatto?',
                  style: TextStyle(
                      fontSize: media.width * 0.05,
                      color: Colors.white,
                      fontFamily: 'Bold'),
                )),
              ),
              SizedBox(height: media.height * 0.01),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder<TestType>(
                        stream: bloc.getReservableTestType,
                        builder: (context, snapshot) {
                          return PrevengoOnboardingRadioButtonInfo(
                            label: 'Pap-test',
                            checked: snapshot.hasData
                                ? snapshot.data == TestType.PAP_TEST
                                    ? true
                                    : false
                                : false,
                            checkColor: Color(0xFFD8A31E),
                            unCheckedColor: Color(0xFFD8B571),
                            onTap: () => bloc.updateReservableTest
                                .add(TestType.PAP_TEST),
                            onInfoTap: null,
                          );
                        }),
                    SizedBox(
                      width: media.width * 0.04,
                    ),
                    StreamBuilder<TestType>(
                        stream: bloc.getReservableTestType,
                        builder: (context, snapshot) {
                          print('snapshot: ${snapshot.data}');
                          return PrevengoOnboardingRadioButtonInfo(
                            label: 'HPV DNA',
                            checked: snapshot.hasData
                                ? snapshot.data == TestType.HPV_DNA
                                    ? true
                                    : false
                                : false,
                            checkColor: Color(0xFFD8A31E),
                            unCheckedColor: Color(0xFFD8B571),
                            onTap: () =>
                                bloc.updateReservableTest.add(TestType.HPV_DNA),
                            onInfoTap: null,
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
          StreamBuilder<TestType>(
            stream: bloc.getReservableTestType,
            builder: (context, snapshot) => snapshot.hasData
                ? Container(
                    height: media.height * 0.4,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: media.width * 0.5,
                                  child: Text(
                                    'Quando hai fatto l\'ultimo esame?',
                                    style: TextStyle(
                                        fontSize: media.width * 0.04,
                                        color: Colors.white,
                                        fontFamily: 'Bold'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    context: context,
                                    builder: (_) => ModalBottomInputDate(
                                      setDate: (value) {
                                        bloc.updateReservation.add(value);

                                        Navigator.pop(context);
                                      },
                                      titleLabel:
                                          'Inserisci l\'anno dell\'esame',
                                      dateFormat: 'yyyy',
                                      colorTheme: ConstantsGraphics
                                          .COLOR_ONBOARDING_YELLOW,
                                      limitUpToday: true,
                                    ),
                                    backgroundColor:
                                        Colors.black.withOpacity(0),
                                    isScrollControlled: true,
                                  ),
                                  child: Container(
                                    height: media.height < 700
                                        ? media.height * 0.07
                                        : media.height * 0.05,
                                    width: media.width * 0.25,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFD8A31E),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Colors.white,
                                            width: 1.5)),
                                    child: Center(
                                      child: StreamBuilder<DateTime>(
                                          stream: bloc.getReservation,
                                          builder: (context, snapshot) {
                                            return Text(
                                              snapshot.hasData
                                                  ? '${snapshot.data.year ?? 'Anno'}'
                                                  : 'Anno',
                                              style: TextStyle(
                                                  fontSize: media.width * .045,
                                                  fontFamily: 'Bold',
                                                  color: Colors.white),
                                            );
                                          }),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: media.height * 0.01),
                            StreamBuilder<Object>(
                                stream: bloc.getDontRememberReservation,
                                builder: (context, snapshot) {
                                  return PrevengoRadioButtonText(
                                    label: 'Non me lo ricordo',
                                    fontSize: media.width * 0.05,
                                    checked: snapshot.hasData
                                        ? snapshot.data
                                        : false,
                                    onTap: () =>
                                        bloc.updateDontRemenberReservation.add(
                                      snapshot.hasData ? !snapshot.data : true,
                                    ),
                                    width: media.width * 0.8,
                                    colorTheme: Color(0xFFD8A31E),
                                  );
                                }),
                          ],
                        ),
                        SizedBox(height: media.height * .06),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: media.width * 0.5,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Carica una foto del referto',
                                          style: TextStyle(
                                              fontSize: media.width * 0.04,
                                              color: Colors.white,
                                              fontFamily: 'Bold'),
                                        ),
                                        TextSpan(
                                          text: '\n(facoltativo)',
                                          style: TextStyle(
                                            fontFamily: 'Bold',
                                            fontSize: media.width * 0.035,
                                            color: ConstantsGraphics
                                                .COLOR_ONBOARDING_BLUE,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              StreamBuilder<File>(
                                  stream: bloc.getOutcomeImage,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return GestureDetector(
                                        onTap: () => showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              PrevengoModalOuctomeImage(
                                            imageFile: snapshot.data,
                                          ),
                                          backgroundColor:
                                              Colors.black.withOpacity(0),
                                          isScrollControlled: true,
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Image.file(
                                            snapshot.data,
                                            height: media.height * 0.1,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CameraScreen(),
                                          ),
                                        ),
                                        child: Container(
                                          height: media.height < 700
                                              ? media.height * 0.07
                                              : media.height * 0.05,
                                          width: media.width * 0.25,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFD8A31E),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              border: Border.all(
                                                  style: BorderStyle.solid,
                                                  color: Colors.white,
                                                  width: 1.5)),
                                          child: Center(
                                              child: SvgPicture.asset(
                                            'assets/icons/upload.svg',
                                            width: media.width * 0.08,
                                          )),
                                        ),
                                      );
                                    }
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: media.width * .05),
              PrevengoOnboardingButtonIcon(
                onTap: () => widget.flashToPage(1),
                icon: Icons.arrow_back_rounded,
                colorTheme: Color(0xFFD8A31E),
                fontSize: media.width * .05,
                label: 'Indietro',
                width: media.width * .35,
              ),
              SizedBox(width: media.width * 0.04),
              PrevengoOnboardingButtonIcon(
                onTap: () {
                  bloc.updateOrgan();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => StreamBuilder<Widget>(
                      stream: bloc.getAlgorithmResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data;
                        } else {
                          return Container(
                            height: 200,
                            width: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                    backgroundColor: Colors.black.withOpacity(0),
                    isScrollControlled: true,
                  );
                },
                icon: Icons.sd_storage_rounded,
                colorTheme: Color(0xFFD8A31E),
                fontSize: media.width * .05,
                label: 'Salva',
                width: media.width * .35,
              ),
            ],
          ),
        ],
      ),
    );
  }
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
