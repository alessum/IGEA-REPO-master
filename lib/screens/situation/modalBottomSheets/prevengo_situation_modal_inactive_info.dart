import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/onboarding/onboarding_breast_bloc.dart';
import 'package:igea_app/blocs/onboarding/onboarding_colon_bloc.dart';
import 'package:igea_app/blocs/onboarding/onboarding_uterus_bloc.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/screens/welcome/breast/onboarding_breast_screen.dart';
import 'package:igea_app/screens/welcome/colon/onboarding_colon_screen.dart';
import 'package:igea_app/screens/welcome/uterus/onboarding_uterus_screen.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class PrevengoSituationModalInactiveInfo extends StatelessWidget {
  const PrevengoSituationModalInactiveInfo({
    Key key,
    @required this.organKey,
  }) : super(key: key);

  final String organKey;
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
                  'Questionario non compilato',
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
          SizedBox(height: media.height * .01),
          Container(
            child: Text(
              'Attualmente non risulta compilato il questionario e non posso consigliarti quando effettuare gli esami di screening. Compila il questionario per permettermi di aiutarti.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: media.width * .045,
                fontFamily: 'Book',
              ),
            ),
          ),
          SizedBox(height: media.height * .03),
          GestureDetector(
            onTap: () {
              switch (organKey) {
                case '001':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingBreastBlocProvider(
                          child: OnboardingBreastScreen(),
                        ),
                      )).then((value) {
                    int count = 0;
                    Navigator.of(context).popUntil((_) {
                      if (count++ >= 2) {
                        return true;
                      } else
                        return false;
                    });
                  });
                  break;
                case '002':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingColonBlocProvider(
                          child: OnboardingColonScreen(),
                        ),
                      )).then((value) {
                    int count = 0;
                    Navigator.of(context).popUntil((_) {
                      if (count++ >= 2) {
                        return true;
                      } else
                        return false;
                    });
                  });
                  break;
                case '003':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingUterusBlocProvider(
                          child: OnboardingUterusScreen(),
                        ),
                      )).then((value) {
                    int count = 0;
                    Navigator.of(context).popUntil((_) {
                      if (count++ >= 2) {
                        return true;
                      } else
                        return false;
                    });
                  });
                  break;
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: media.height * 0.01),
              decoration: BoxDecoration(
                  color: ConstantsGraphics.lightGreen,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Text(
                  'Compila il questionario',
                  style: TextStyle(
                      fontSize: media.width * 0.06,
                      fontFamily: 'Bold',
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
