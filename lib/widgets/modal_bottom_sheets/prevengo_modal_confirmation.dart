import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///
///### Prevengo Diary Modal Confirm Standard Screening
///Finestra modale per la conferma dello screening standard per il calcolo dell'esame successivo, all'inserimento dell'esito
class PrevengoModalConfirmation extends StatelessWidget {
  PrevengoModalConfirmation({
    Key key,
    @required this.title,
    @required this.iconPath,
    @required this.message,
    @required this.colorTheme,
    @required this.popScreensNumber,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final String message;
  final Color colorTheme;
  final int popScreensNumber;

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
          SizedBox(height: media.height * 0.02),
          GestureDetector(
            onTap: () {
              int count = 0;
              Navigator.of(context).popUntil((_) {
                if (count++ >= popScreensNumber) {
                  return true;
                } else
                  return false;
              });
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
