import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class PrevengoUterusModalVaccineInfo extends StatelessWidget {
  const PrevengoUterusModalVaccineInfo({Key key}) : super(key: key);

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
                  'Vaccino HPV',
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
                    text: 'L\'introduzione del vaccino contro il ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Papilloma Virus ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        'nasce da uno studio che ha evidenziato la riduzioni di casi di infezioni da Papilloma Virus e patologie ad esso associato (come: tumore della cervice uterina, tumore del pene, condilomi ano-genitali e tumori oro-faringei) in seguito ad un ciclo vaccinale completo.',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' Questo vaccino è rivolto in particolare alle donne tra i ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: '12 ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'e i ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: '26 anni',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ', ma è stata dimostrata una forte efficacia anche nelle donne fino a ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: '45 anni. ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Il vaccino si è dimostrato utile anche nel ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'maschio',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ', non solo per prevenire possibili patologie legate al virus, ma anche per ridurne la circolazione.',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
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
          )
        ],
      ),
    );
  }
}
