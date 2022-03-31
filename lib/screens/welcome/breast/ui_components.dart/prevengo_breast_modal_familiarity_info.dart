import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_chatbot.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/screens/welcome/breast/ui_components.dart/prevengo_onboarding_counter_parent_button.dart';
import 'package:igea_app/screens/welcome/breast/ui_components.dart/prevengo_onboarding_simple_parent_button.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class PrevengoBreastModalFamiliarityInfo extends StatelessWidget {
  const PrevengoBreastModalFamiliarityInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: EdgeInsets.all(media.width * .05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CloseLineTopModal(),
          SizedBox(height: media.height * .02),
          Row(
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/avatars/arold_in_circle.svg',
                  height: media.width * .15,
                ),
              ),
              SizedBox(
                width: media.width * .03,
              ),
              Container(
                width: media.width * .5,
                child: Text(
                  'Informazioni sulla familiarità',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: media.width * .06,
                    fontFamily: 'Gotham',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: media.height * .03),
          Container(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Selezionare i parenti di genere maschile ai quali sono stati diagnosticati i seguenti carcinomi:\n',
                    style: TextStyle(
                        fontSize: media.width * .046,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Mammella, Prostata, Pancreas',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: media.height * .01),
          Container(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Selezionare i parenti di genere femminile ai quali sono stati diagnosticati i seguenti carcinomi:\n',
                    style: TextStyle(
                        fontSize: media.width * .046,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Mammella, Ovaio/Peritoneo/Tube, Pancreas',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: media.height * .03),
          Container(
            child: Text(
              'Usare i pulsanti di selezione mostrati come in esempio:',
              style: TextStyle(
                fontSize: media.width * .046,
                fontFamily: 'Book',
              ),
            ),
          ),
          SizedBox(height: media.height * .01),
          Align(
            alignment: Alignment.centerLeft,
            child: PrevengoOnboardingSimpleParentButton(
              label: 'Papà',
              iconPath: 'assets/avatars/Papa.svg',
              isChecked: false,
              onTap: null,
            ),
          ),
          SizedBox(height: media.height * .01),
          PrevengoOnboardingCounterParentButton(
            label: 'Sorella',
            iconPath: 'assets/avatars/Mamma.svg',
            counter: '0',
            onAddTap: null,
            onRemoveTap: null,
          ),
          SizedBox(height: media.height * .03),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatbotBlocProvider(
                    child: Chatbot(
                      suggestedMessageList: [],
                      inputMessage: 'Cosa si intende per familiarità?',
                    ),
                  ),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: media.height * 0.01),
              decoration: BoxDecoration(
                  color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Text(
                  'Maggiori informazioni',
                  style: TextStyle(
                      fontSize: media.width * 0.06,
                      fontFamily: 'Bold',
                      color: Colors.white),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: media.height * 0.01),
              decoration: BoxDecoration(
                  color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Text(
                  'Ok, ho capito',
                  style: TextStyle(
                      fontSize: media.width * 0.06,
                      fontFamily: 'Bold',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
