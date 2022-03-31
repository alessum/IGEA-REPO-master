import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class PrevengoMainQuestionaryModalInfo extends StatelessWidget {
  const PrevengoMainQuestionaryModalInfo({Key key}) : super(key: key);

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
                  'Ben fatto!!',
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
                        'Ora dovresti compilare alcuni questionari per aiutarmi a conoscerti meglio, così da poterti aiutare nel migliore dei modi.\nSe non hai tempo di compilare i questionari, stai tranquillo, potrai compilarli in seguito nella sezione “Situazione”',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
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
                    text: 'I questionari psicologici sono in via di sviluppo\n',
                    style: TextStyle(
                        fontSize: media.width * .05,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  // TextSpan(
                  //   text:
                  //       'Pertanto potrai vedere solamente alcune domande e rispondere senza avere un risultato sulla tua classificazione psicologica',
                  //   style: TextStyle(
                  //       fontSize: media.width * .048,
                  //       fontFamily: 'Book',
                  //       color: Colors.black),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: media.height * .03),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: media.height * 0.01),
              decoration: BoxDecoration(
                  color: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
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
          )
        ],
      ),
    );
  }
}
