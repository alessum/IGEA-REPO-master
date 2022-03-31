import 'package:flutter/material.dart';

class ButtonRoundedConfirmation extends StatelessWidget {
  ButtonRoundedConfirmation({
    Key key,
    @required this.label,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonColor,
  }) : super(key: key);

  final String label;
  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      height: buttonHeight == null
          ? media.height > 600
              ? 40
              : 30
          : buttonHeight,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: buttonWidth == null ? media.width * 0.4 : buttonWidth,
      decoration: BoxDecoration(
          color: buttonColor != null ? buttonColor : Color(0xFFD8A31E),
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(
              style: BorderStyle.solid, color: Colors.white, width: 1.5)),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
              fontFamily: 'Gotham',
              fontSize: media.width * 0.05,
              color: Colors.white),
        ),
      ),
    );
  }
}
