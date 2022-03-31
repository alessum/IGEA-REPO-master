import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/blocs/onboarding/onboarding_breast_bloc.dart';
import 'package:igea_app/models/constants/constants_chatbot_messages.dart';
import 'package:igea_app/screens/welcome/breast/ui_components.dart/prevengo_breast_modal_familiarity_info.dart';
import 'package:igea_app/screens/welcome/breast/ui_components.dart/prevengo_onboarding_counter_parent_button.dart';
import 'package:igea_app/screens/welcome/breast/ui_components.dart/prevengo_onboarding_simple_familiarity_button.dart';
import 'package:igea_app/screens/welcome/breast/ui_components.dart/prevengo_onboarding_simple_parent_button.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';

class FamiliarityForm extends StatefulWidget {
  FamiliarityForm({
    Key key,
  }) : super(key: key);

  @override
  _FamiliarityFormState createState() => _FamiliarityFormState();
}

class _FamiliarityFormState extends State<FamiliarityForm> {
  OnboardingBreastBloc bloc;

  Map<String, String> _relativeList = {
    'Fratello': 'assets/avatars/Papa.svg',
    'Sorella': 'assets/avatars/Mamma.svg',
    'Zia': 'assets/avatars/Mamma.svg',
    'Nonno': 'assets/avatars/Nonno.svg',
    'Nonna': 'assets/avatars/Nonna.svg',
  };

  void _getParentAction(String parent, int value) {
    if (value >= 0 && value <= 3) {
      switch (parent) {
        case 'Fratello':
          bloc.setBrotherCounter.add(value);
          break;
        case 'Sorella':
          bloc.setSisterCounter.add(value);
          break;
        case 'Zia':
          bloc.setAuntCounter.add(value);
          break;
        case 'Nonno':
          if (value < 3) bloc.setGrandPACounter.add(value);
          break;
        case 'Nonna':
          if (value < 3) bloc.setGrandMACounter.add(value);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingBreastBlocProvider.of(context);

    List<Stream> _parentStreamList = [
      bloc.getBrotherCounter,
      bloc.getSisterCounter,
      bloc.getAuntCounter,
      bloc.getGrandPACounter,
      bloc.getGrandMACounter,
    ];

    return Container(
      height: media.height * 0.76,
      width: media.width,
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xFFE5D4A8),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
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
                      style: BorderStyle.solid,
                      color: Colors.white,
                      width: 1.5)),
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
                        builder: (context) =>
                            PrevengoBreastModalFamiliarityInfo(),
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
            SizedBox(
              height: media.height * 0.02,
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
            SizedBox(height: media.height * 0.01),
            Container(
              height: media.height * 0.48,
              width: media.width * 0.85,
              child: ListView.separated(
                  itemBuilder: (context, index) => StreamBuilder<int>(
                      stream: _parentStreamList[index],
                      builder: (context, snapshot) {
                        return PrevengoOnboardingCounterParentButton(
                          label: _relativeList.keys.elementAt(index),
                          iconPath: _relativeList.values.elementAt(index),
                          counter: snapshot.hasData ? '${snapshot.data}' : '0',
                          onAddTap: () => _getParentAction(
                            _relativeList.keys.elementAt(index),
                            snapshot.hasData ? snapshot.data + 1 : 1,
                          ),
                          onRemoveTap: () => _getParentAction(
                            _relativeList.keys.elementAt(index),
                            snapshot.hasData ? snapshot.data + -1 : 1,
                          ),
                        );
                      }),
                  separatorBuilder: (context, index) => SizedBox(
                        height: media.height * 0.01,
                      ),
                  itemCount: _relativeList.length),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
          ],
        ),
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
