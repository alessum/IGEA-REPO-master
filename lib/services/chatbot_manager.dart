import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/widgets/ui_components/bubble_message.dart';
import 'package:igea_app/widgets/ui_components/button_rounded_confirmation.dart';

class ChatbotManager {
  static final String onboardingMenuBubble =
      'Per poterti aiutare ho bisogno di sapere da te alcune informazioni!';
  static final String onboardingRegistryBubble = '';
  static final String onboardingBreastFamiliarityBubble =
      'Seleziona i parenti che hanno avuto un tumore alla mammella o al pancreas o alle ovaie o al peritoneo, oppure clicca sul pulsante "Non ho familiarità"';
  static final String onboardingColonFamiliarityBubble =
      'Per continuare seleziona i parenti che hanno avuto un carcinoma al colon retto, oppure clicca sul pulsante "Non ho familiarità"';
  static final String onboardingUterusVaccineBubble =
      'Hai fatto il vaccino anti hpv? E\' importante farlo anche se sei un maschio';

  static final List<String> defaultSuggestedList = [
    'Quando ho la prossima visita?',
    'Sono in ritardo per qualche esame?',
    'Devo prenotare qualche esame?',
  ];

  static final List<String> onboardingMenuSuggestedList = [
    'Perchè devo compilare i questionari?',
    'Posso compilarli in un secondo momento?',
    'Quanto dura la compilazione?',
  ];

  static final List<String> onboardingRegistrySuggestedList = [
    'Perchè devo inserire questi dati?',
    'Le mie informazioni sono al sicuro?'
  ];

  static final List<String> onboardingBreastFamSuggestedList = [
    'A cosa serve la familiarità?',
    'Se ho familiarità positiva avrò il tumore?',
    'Cosa lega i tumori al pancreas, all\'ovaio\ne al peritoneo con quello al seno?',
  ];

  static final List<String> onboardingBreastSuggestedList = [
    'A cosa serve la familiarità?',
    'Un uomo può avere il tumore al seno?',
    'Cosa lega i tumori al pancreas, all\'ovaio\ne al peritoneo con quello al seno?',
  ];

  static final List<String> onboardingColonFamSuggestedList = [
    'A cosa serve la familiarità?',
    'Se ho familiarità positiva avrò il tumore?',
    'TERZO SUGGERIMENTO',
  ];

  static void showAroldModalDialog(BuildContext context, String message) {
    Size media = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            elevation: 0,
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: media.height * 0.35,
                width: media.width * 0.9,
                child: Stack(
                  children: [
                    Container(
                        height: media.height * 0.3,
                        width: media.width * 0.8,
                        padding: EdgeInsets.all(media.width * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              message,
                              style: TextStyle(
                                fontFamily: 'Book',
                                fontSize: media.width * 0.05,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ButtonRoundedConfirmation(
                                label: 'Ho capito',
                                buttonColor:
                                    ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                                buttonWidth: media.width * 0.4,
                                buttonHeight: media.height * 0.05,
                              ),
                            )
                          ],
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SvgPicture.asset("assets/avatars/arold_extended.svg",
                          height: media.height * 0.2),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void showBubble(BuildContext context, String message) {
    Size media = MediaQuery.of(context).size;
    FToast fToast = FToast();
    fToast.init(context);

    Timer(Duration(milliseconds: 800), () {
      // Custom Toast Position
      fToast.showToast(
          child: GestureDetector(
              onTap: () {
                fToast.removeCustomToast();
                print('toast touched');
              },
              child: Container(
                height: media.height,
                width: media.width,
                decoration: BoxDecoration(color: Color(0x22000000)),
                child: Stack(children: <Widget>[
                  Opacity(
                    opacity: 0.55,
                    child: Container(
                      color: Colors.black,
                      width: media.width,
                      height: media.height,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: BubbleMessage(
                      message: message,
                    ),
                  ),
                ]),
              )),
          toastDuration: Duration(days: 365),
          positionedToastBuilder: (context, child) {
            return Positioned(
              child: child,
              bottom: 0, //media.height * 0.04,
              left: 0, //media.width * 0.07,
            );
          });
    });
  }
}
