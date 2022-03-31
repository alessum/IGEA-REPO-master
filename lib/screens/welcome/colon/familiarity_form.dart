import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/blocs/onboarding/onboarding_colon_bloc.dart';
import 'package:igea_app/screens/welcome/breast/ui_components.dart/prevengo_onboarding_simple_familiarity_button.dart';
import 'package:igea_app/screens/welcome/breast/ui_components.dart/prevengo_onboarding_simple_parent_button.dart';
import 'package:igea_app/screens/welcome/uterus/ui_components/prevengo_radio_button_text.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:tuple/tuple.dart';
import 'ui_components/prevengo_colon_modal_familiarity_info.dart';

class FamiliarityForm extends StatefulWidget {
  FamiliarityForm({
    Key key,
  }) : super(key: key);

  @override
  _FamiliarityFormState createState() => _FamiliarityFormState();
}

class _FamiliarityFormState extends State<FamiliarityForm> {
  OnboardingColonBloc bloc;

  List<Map<String, bool>> _syndromList = [
    {'Sindrome di Lynch': false},
    {'Sindrome di Peutz-jeghers': false},
    {'Sindrome adenomatosa familiare': false},
    {'Sindrome di Gardner': false},
  ];

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingColonBlocProvider.of(context);

    return Container(
      height: media.height * 0.7,
      width: media.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xFFE5D4A8),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: media.height * 0.055,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: media.width * 0.7,
            decoration: BoxDecoration(
                color: Color.alphaBlend(Color(0xFFD8A31E), Color(0xFFE8B21C)),
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(
                    style: BorderStyle.solid, color: Colors.white, width: 1.5)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    ' Familiarità',
                    style: TextStyle(
                        fontFamily: 'Book',
                        fontSize: media.width * 0.05,
                        color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => PrevengoColonModalFamiliarityInfo(),
                      backgroundColor: Colors.black.withOpacity(0),
                      isScrollControlled: true,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/info.svg',
                      width: media.width * 0.06,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: media.width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<bool>(
                    stream: bloc.getCheckDad,
                    builder: (context, snapshot) {
                      return PrevengoOnboardingSimpleParentButton(
                        label: 'Papà',
                        iconPath: 'assets/avatars/Papa.svg',
                        isChecked: snapshot.hasData ? snapshot.data : false,
                        onTap: () => bloc.setCheckDad
                            .add(snapshot.hasData ? !snapshot.data : true),
                      );
                    }),
                StreamBuilder<bool>(
                    stream: bloc.getCheckMom,
                    builder: (context, snapshot) {
                      return PrevengoOnboardingSimpleParentButton(
                        label: 'Mamma',
                        iconPath: 'assets/avatars/Mamma.svg',
                        isChecked: snapshot.hasData ? snapshot.data : false,
                        onTap: () => bloc.setCheckMom
                            .add(snapshot.hasData ? !snapshot.data : true),
                      );
                    }),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: media.width * .05),
            child: StreamBuilder<bool>(
                stream: bloc.getCheckNoFamiliarity,
                builder: (context, snapshot) {
                  return PrevengoOnboardingSimpleFamiliarityButton(
                    label: 'Non ho familiarità',
                    isChecked: snapshot.hasData ? snapshot.data : false,
                    onTap: () => bloc.setCheckNoFamiliarity
                        .add(snapshot.hasData ? !snapshot.data : true),
                  );
                }),
          ),
          SizedBox(height: media.height * .01),
          Container(
            padding: EdgeInsets.symmetric(horizontal: media.width * 0.05),
            child: Text(
              'È nota in famiglia una o più delle seguenti sindromi?',
              style: TextStyle(
                fontSize: media.width * .05,
                fontFamily: 'Bold',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: media.width * .05),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: media.height * .4),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    PrevengoOnboardingSimpleFamiliarityButton(
                  label: _syndromList[index].keys.first,
                  isChecked: _syndromList[index].values.first,
                  onTap: () {
                    bloc.setCheckSyndromsSubject
                        .add(!_syndromList[index].values.first);
                    setState(() {
                      _syndromList[index][_syndromList[index].keys.first] =
                          !_syndromList[index].values.first;
                    });
                  },
                ),
                separatorBuilder: (context, _) =>
                    SizedBox(height: media.height * .01),
                itemCount: _syndromList.length,
              ),
            ),
          ),
          SizedBox(height: media.height * .01),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     StreamBuilder<bool>(
          //         stream: bloc.getCheckSyndromsSubject,
          //         builder: (context, snapshot) {
          //           return PrevengoRadioButtonText(
          //             width: media.width * .4,
          //             fontSize: media.width * .045,
          //             label: 'Si',
          //             checked: snapshot.hasData ? snapshot.data : false,
          //             onTap: () => bloc.setCheckSyndromsSubject.add(true),
          //             colorTheme: Color(0xFFE8B21C),
          //           );
          //         }),
          //     StreamBuilder<bool>(
          //         stream: bloc.getCheckSyndromsSubject,
          //         builder: (context, snapshot) {
          //           return PrevengoRadioButtonText(
          //             width: media.width * .4,
          //             fontSize: media.width * .045,
          //             label: 'No',
          //             checked: snapshot.hasData ? !snapshot.data : false,
          //             onTap: () => bloc.setCheckSyndromsSubject.add(false),
          //             colorTheme: Color(0xFFE8B21C),
          //           );
          //         }),
          //   ],
          // ),
        ],
      ),
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
}
