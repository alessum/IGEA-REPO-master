import 'package:flutter/material.dart';

class NoInAgeOfScreeningPage extends StatelessWidget {

  NoInAgeOfScreeningPage({
      Key key,
      @required this.setQuestionaryDone,
    }) : super(key: key);

  final Function() setQuestionaryDone;

  @override
  Widget build(BuildContext context) {

    Size media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container( 
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Per ora non preoccuparti',
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: media.width * 0.06,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: media.height * 0.03),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ti ricorderò io il momento giusto per iniziare a eseguire con regolarità il Pap Test! Nel frattempo concentriamoci insieme su un corretto stile di vita!',
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
          ),
        ],
      ),
    );
  }
}