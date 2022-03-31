import 'package:flutter/material.dart';

class FormFieldTextFixedValue extends StatelessWidget {
  const FormFieldTextFixedValue({
    Key key,
    @required this.label,
    @required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: media.width * 0.55,
          child: Text(
            label,
            style: TextStyle(
              fontSize: media.width * 0.035,
              fontFamily: 'Bold',
            ),
          ),
        ),
        Stack(
          children: [
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
                child: Text(
                  value,
                  style: TextStyle(
                      fontSize: media.width * 0.045,
                      color: Colors.white,
                      fontFamily: 'book'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
