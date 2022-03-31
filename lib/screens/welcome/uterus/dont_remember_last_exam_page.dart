import 'package:flutter/material.dart';

class DontRememberLastExamPage extends StatelessWidget {

  DontRememberLastExamPage({
    Key key,
    @required this.setQuestionaryDone,
  }) : super(key: key);

  final Function() setQuestionaryDone;

  @override
  Widget build(BuildContext context) {

    Size media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: media.height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: media.height * 0.2),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
                child:  Text(
              'Non ti preoccupare, te lo chiederò in seguito!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                height: media.height * 0.0015,
                fontSize: media.width * 0.07,
                fontFamily: 'Gotham',
              ),
            )),
          ),
          SizedBox(height: media.height * 0.19),
          GestureDetector(
            onTap: () {
              setQuestionaryDone();
            },
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: media.width * 0.5,
                padding: EdgeInsets.all(media.width < 350 ? 5 : 8),
                decoration: BoxDecoration(
                    color: Color(0xFF5C88C1),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.white)),
                child: Center(
                  child: Text(
                    'Salva e continua',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bold',
                        fontSize: media.width * 0.05),
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