import 'package:flutter/material.dart';

class FamiliarityOutputPage extends StatelessWidget {
  const FamiliarityOutputPage({
    Key key,
    @required this.setQuestionaryDone,
  }) : super(key: key);

  final Function() setQuestionaryDone;
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: media.height * 0.01),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Attenzione!',
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: media.width * 0.07,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: media.width * 0.02),
                  Text(
                    'Data la tua familiarità ti consiglio di rivolgerti ad un ambulatorio del rischio eredo-familiare (rivolgiti ad un senologo o parlane al tuo medico di base)',
                    style: TextStyle(
                        fontFamily: 'Book',
                        height: 1.2,
                        fontSize: media.width * 0.05,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
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
                  //TODO: linkare video
                  'Guarda il video',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: media.width * 0.05,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: media.height * 0.15),
            GestureDetector(
              onTap: () => setQuestionaryDone(),
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
          ]),
    );
  }
}
