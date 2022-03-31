import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_chatbot.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class PrevengoModalScreeningGuidelines extends StatelessWidget {
  const PrevengoModalScreeningGuidelines({Key key}) : super(key: key);

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
                  'I programmi di screening nazionali',
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
                        'Ogni anno le Aziende Sanitarie distribuite su tutto il territorio nazionale provvedono ad inviare automaticamente a casa, se si è compresi nelle fasce d’età coinvolte, ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'una lettera di appuntamento ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'per gli esami di screening.\n',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        'In Italia i programmi di screening nazionali sono 3: uno per la prevenzione del ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'tumore al seno, ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'uno per la prevenzione del ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'tumore al colon-retto ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'e per uno per la prevenzione del ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'tumore alla cervice uterina. ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        'Si tratta di campagne nazionali che offrono esami di screening ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Book',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'gratuiti alla popolazione ',
                    style: TextStyle(
                        fontSize: media.width * .048,
                        fontFamily: 'Bold',
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        '(mammografia, ricerca del sangue occulto nelle feci, pap-test), a cadenza regolare, finalizzati a diagnosticare precocemente questi tumori, così da poterli curare meglio e ridurne la mortalità.',
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
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatbotBlocProvider(
                    child: Chatbot(
                      suggestedMessageList: [],
                      inputMessage: 'Se non ho ricevuto la lettera?',
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
                  'Se non ho ricevuto la lettera?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: media.width * 0.05,
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
          )
        ],
      ),
    );
  }
}
