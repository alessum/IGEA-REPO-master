import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class PrevengoUterusPaptestModalInfo extends StatelessWidget {
  const PrevengoUterusPaptestModalInfo({Key key}) : super(key: key);

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
                  'Cos\'è un PAP Test?',
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
          // Container(
          //   child: RichText(
          //     text: TextSpan(
          //       children: [
          //         TextSpan(
          //           text: 'Ciao!!\n',
          //           style: TextStyle(
          //               fontSize: media.width * .05,
          //               fontFamily: 'Bold',
          //               color: Colors.black),
          //         ),
          //         TextSpan(
          //           text:
          //               'Per il corretto funzionamento dell\'applicazione devo chiederti di inserire alcuni tuoi dati personali',
          //           style: TextStyle(
          //               fontSize: media.width * .048,
          //               fontFamily: 'Book',
          //               color: Colors.black),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: media.height * .01),
          Container(
            child: Text(
              'Per il PAP test viene prelevato un campione dalla cervice, che viene poi inviato al laboratorio, dove è esaminato al microscopio per individuare anomalie cellulari, che possono indicare modificazioni precancerose o, raramente, la presenza di un tumore della cervice.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: media.width * .045,
                fontFamily: 'Book',
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
