import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ModalBottomColonRelativesAgeQuestion extends StatelessWidget {
  ModalBottomColonRelativesAgeQuestion({
    Key key,
    @required this.onChangeAge,
    @required this.onConfirm,
  }) : super(key: key);

  final Function(String age) onChangeAge;
  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        height: media.height * 0.35,
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
                        'A che età il tuo parente ha riscontrato il carcinoma?',
                        style: TextStyle(
                            fontFamily: 'Book', fontSize: media.width * 0.05),
                      ),
                    ),
                  )
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
                      'Età parente',
                      style: TextStyle(
                          fontFamily: 'Gotham', fontSize: media.width * 0.05),
                    ),
                  ),
                  Container(
                      height: media.height < 700
                          ? media.height * 0.07
                          : media.height * 0.05,
                      width: media.width * 0.25,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color(0xFFD8A31E),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.white,
                              width: 1.5)),
                      child: Center(
                        child: TextFormField(
                          style: TextStyle(
                              fontFamily: 'Book',
                              fontSize: media.width * 0.05,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: false,
                            contentPadding:
                                const EdgeInsets.fromLTRB(.0, .0, .0, 10.0),
                            errorMaxLines: 1,
                            hintText: 'età',
                            hintStyle: TextStyle(
                                fontFamily: 'Book',
                                fontSize: media.width * 0.05,
                                color: Colors.white),
                            // suffixIcon: Icon(
                            //   Icons.edit,
                            //   color: Colors.white,
                            //   size: media.width * 0.05,
                            // ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            onChangeAge(val);
                          },
                        ),
                      ))
                ],
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  onConfirm();
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
      ),
    );
  }
}
