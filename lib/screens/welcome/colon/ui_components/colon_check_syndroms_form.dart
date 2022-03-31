import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:igea_app/blocs/onboarding/onboarding_colon_bloc.dart';
import 'package:igea_app/screens/welcome/uterus/ui_components/prevengo_radio_button_text.dart';

class ColonCheckSyndromsForm extends StatelessWidget {
  const ColonCheckSyndromsForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    OnboardingColonBloc bloc = OnboardingColonBlocProvider.of(context);

    return Container(
      padding: EdgeInsets.all(media.width * 0.05),
      height: media.height * 0.4,
      width: media.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xFFE5D4A8),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'È nota in famiglia una o più delle seguenti sindromi?',
            style: TextStyle(
              fontSize: media.width * .05,
              fontFamily: 'Bold',
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFEEE7D0),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                      child: Text(
                    'Sindrome di Lynch',
                    style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Book',
                    ),
                  )),
                ),
                SizedBox(height: media.height * .01),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFEEE7D0),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                      child: Text(
                    'Sindrome di Peutz-jeghers',
                    style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Book',
                    ),
                  )),
                ),
                SizedBox(height: media.height * .01),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFEEE7D0),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                      child: Text(
                    'Poliposi adenomatosa familiare',
                    style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Book',
                    ),
                  )),
                ),
                SizedBox(height: media.height * .01),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFEEE7D0),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                      child: Text(
                    'Sindrome di Gardner',
                    style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Book',
                    ),
                  )),
                ),
              ],
            ),
          ),
          SizedBox(height: media.height * .01),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     StreamBuilder<bool>(
          //       stream: bloc.getCheckSyndromsSubject,
          //       builder: (context, snapshot) {
          //         return PrevengoRadioButtonText(
          //           width: media.width * .4,
          //           fontSize: media.width * .045,
          //           label: 'Si',
          //           checked: snapshot.hasData ? snapshot.data : false,
          //           onTap: () => bloc.setCheckSyndromsSubject.add(true),
          //           colorTheme: Color(0xFFE8B21C),
          //         );
          //       }
          //     ),
          //     StreamBuilder<bool>(
          //       stream: bloc.getCheckSyndromsSubject,
          //       builder: (context, snapshot) {
          //         return PrevengoRadioButtonText(
          //           width: media.width * .4,
          //           fontSize: media.width * .045,
          //           label: 'No',
          //           checked: snapshot.hasData ? !snapshot.data : false,
          //           onTap: () => bloc.setCheckSyndromsSubject.add(false),
          //           colorTheme: Color(0xFFE8B21C),
          //         );
          //       }
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
