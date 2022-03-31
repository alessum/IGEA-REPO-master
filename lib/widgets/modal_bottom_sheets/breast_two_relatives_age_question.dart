import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ModalBottomBreastTwoRelativesAgeQuestion extends StatefulWidget {
  ModalBottomBreastTwoRelativesAgeQuestion({
    Key key,
    @required this.relatives,
    @required this.setFamiliarity,
  }) : super(key: key);

  final List<String> relatives;
  final Function(bool familiarity) setFamiliarity;

  @override
  _ModalBottomBreastTwoRelativesAgeQuestionState createState() =>
      _ModalBottomBreastTwoRelativesAgeQuestionState();
}

class _ModalBottomBreastTwoRelativesAgeQuestionState
    extends State<ModalBottomBreastTwoRelativesAgeQuestion> {
  bool _relativeCheckAge1 = false;
  bool _relativeCheckAge2 = false;
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    if (widget.relatives.length > 2)
      print('[ERR][MODAL BREAST RELATIVES]\nTroppi parenti: ' +
          widget.relatives.length.toString());

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      height: media.height > 700 ? media.height * 0.5 : media.height * 0.5,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 3,
            width: 75,
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.all(Radius.circular(25))),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/avatars/arold_in_circle.svg',
                  width: media.width * 0.15,
                ),
                SizedBox(width: media.width * 0.05),
                Expanded(
                    child: Container(
                        child: Text(
                            'Quando i tuoi parenti hanno riscontrato il tumore avevano meno di 50 anni?',
                            style: TextStyle(
                                fontFamily: 'Book',
                                fontSize: media.width * 0.045))))
              ],
            ),
          ),
          // SizedBox(
          //   height: media.height * 0.01,
          // ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: media.width < 360 ? media.width * 0.05 : 0.01,
                vertical: media.width < 360 ? 10 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: media.width * 0.35,
                  child: Text(
                    widget.relatives[0],
                    style: TextStyle(
                        fontFamily: 'Gotham', fontSize: media.width * 0.05),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _relativeCheckAge1 = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: _relativeCheckAge1
                          ? Color(0xFFD8A31E)
                          : Color.alphaBlend(Colors.white70, Color(0xFFE8B21C)),
                    ),
                    child: Center(
                      child: Text(
                        'Si',
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            color: Colors.white,
                            fontSize: media.width * 0.05),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _relativeCheckAge1 = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: !_relativeCheckAge1
                          ? Color(0xFFD8A31E)
                          : Color.alphaBlend(Colors.white70, Color(0xFFE8B21C)),
                    ),
                    child: Center(
                      child: Text(
                        'No',
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            color: Colors.white,
                            fontSize: media.width * 0.05),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: media.width < 360 ? media.width * 0.05 : 0.01,
                vertical: media.width < 360 ? 10 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: media.width * 0.35,
                  child: Text(
                    widget.relatives[1],
                    style: TextStyle(
                        fontFamily: 'Gotham', fontSize: media.width * 0.05),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _relativeCheckAge2 = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: _relativeCheckAge2
                          ? Color(0xFFD8A31E)
                          : Color.alphaBlend(Colors.white70, Color(0xFFE8B21C)),
                    ),
                    child: Center(
                      child: Text(
                        'Si',
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            color: Colors.white,
                            fontSize: media.width * 0.05),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _relativeCheckAge2 = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: !_relativeCheckAge2
                          ? Color(0xFFD8A31E)
                          : Color.alphaBlend(Colors.white70, Color(0xFFE8B21C)),
                    ),
                    child: Center(
                      child: Text(
                        'No',
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            color: Colors.white,
                            fontSize: media.width * 0.05),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if(_relativeCheckAge1 && _relativeCheckAge2)
                  widget.setFamiliarity(true);
                else widget.setFamiliarity(false);
                  Navigator.pop(context);
              },
              child: Container(
                height: media.height > 600 ? 40 : 30,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                margin: EdgeInsets.symmetric(vertical: 10),
                width: media.width * 0.4,
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
                    'Conferma',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.05,
                        color: Colors.white),
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
