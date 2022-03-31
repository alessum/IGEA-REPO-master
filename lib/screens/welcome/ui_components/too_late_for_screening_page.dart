import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TooLateForScreeningPage extends StatelessWidget {
  TooLateForScreeningPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding:
          EdgeInsets.only(bottom: media.height * .01, top: media.height * .25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(media.width * 0.05),
            margin: EdgeInsets.symmetric(horizontal: media.width * .05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Color(0xFFD8A31E),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: SvgPicture.asset(
                    'assets/avatars/arold_in_circle.svg',
                    height: media.width * 0.15,
                  ),
                ),
                SizedBox(height: media.height * 0.01),
                Text(
                  'Il servizio di screening è terminato!',
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: media.width * 0.06,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: media.height * 0.02),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Continuerò ad aiutarti a manatenere un corretto stile di vita e ad assisterti nella gestione dei tuoi medicinali, qualora ne avessi bisogno! ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Book',
                        height: 1.4,
                        fontSize: media.width * 0.05,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: media.height > 600 ? 40 : 30,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                margin: EdgeInsets.symmetric(vertical: 10),
                width: media.width * 0.5,
                decoration: BoxDecoration(
                    color: Color(0xFFD8A31E),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.white,
                        width: 1.5)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ok, ho capito',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.05,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
