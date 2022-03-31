import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_chatbot.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:tuple/tuple.dart';

///
///### Prevengo Diary Modal Confirm Standard Screening
///Finestra modale per la conferma dello screening standard per il calcolo dell'esame successivo, all'inserimento dell'esito
class PrevengoDiaryModalCSS extends StatelessWidget {
  PrevengoDiaryModalCSS({
    Key key,
    @required this.title,
    @required this.iconPath,
    @required this.message,
    this.suggestedBooking,
    @required this.colorTheme,
    @required this.isAlert,
    this.chatbotInfoData,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final String message;
  final String suggestedBooking;
  final Color colorTheme;
  final bool
      isAlert; // usato per non tornare alla pagina principale del diario degli esiti
  final Tuple2<String, String> chatbotInfoData;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      // height: media.height * 0.6,
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: colorTheme,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: media.height * 0.04),
            child: SvgPicture.asset(
              iconPath,
              height: media.height * 0.1,
            ),
          ),
          SizedBox(height: media.height * 0.03),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: media.width * 0.08,
              fontFamily: 'Gotham',
              color: Colors.white,
            ),
          ),
          SizedBox(height: media.height * 0.01),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: media.width * 0.06,
                fontFamily: 'Book',
              ),
            ),
          ),
          Text(
            suggestedBooking ?? '',
            style: TextStyle(
              fontSize: media.width * 0.07,
              fontFamily: 'Gotham',
              color: Colors.white,
            ),
          ),
          SizedBox(height: media.height * 0.02),
          chatbotInfoData != null
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatbotBlocProvider(
                          child: Chatbot(
                            suggestedMessageList: [],
                            inputMessage: chatbotInfoData.item2,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Center(
                      child: Text(
                        chatbotInfoData.item1,
                        style: TextStyle(
                          fontSize: media.width * 0.06,
                          fontFamily: 'Bold',
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          GestureDetector(
            onTap: () {
              if (isAlert) {
                Navigator.pop(context);
              } else {
                int count = 0;
                Navigator.of(context).popUntil((_) {
                  if (count++ >= 2) {
                    return true;
                  } else
                    return false;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: media.height * 0.01),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Text(
                  'Ok, grazie!',
                  style: TextStyle(
                    fontSize: media.width * 0.06,
                    fontFamily: 'Bold',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
