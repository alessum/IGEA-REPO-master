import 'package:flutter/material.dart';

class ButtonRadioTextContainer extends StatelessWidget {
  const ButtonRadioTextContainer({
    Key key,
    @required this.label,
    @required this.checked,
    this.nonCheckedColor,
    this.checkedColor,
  }) : super(key: key);

  final String label;
  final bool checked;
  final Color nonCheckedColor;
  final Color checkedColor;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      height: media.height < 700 ? media.height * 0.065 : media.height * 0.07,
      width: media.width * 0.4,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // color: (() {
        //   if (checked == true) {
        //     return Color(0xFFD8A31E);
        //   } else {
        //     return Color(0xFFD8B571);
        //   }
        // }()),
        color: checked
            ? checkedColor != null
                ? checkedColor
                : Color(0xFFD8A31E)
            : nonCheckedColor != null
                ? nonCheckedColor
                : Color(0xFFD8B571),
        borderRadius: BorderRadius.all(Radius.circular(35)),
        // border: Border.all(
        //   style: BorderStyle.solid,
        //   color: Colors.white,
        //   width: (() {
        //     if (checked == true) {
        //       return 3.0;
        //     } else {
        //       return 1.5;
        //     }
        //   }()),
        // ),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: media.width * 0.04,
              color: Colors.white,
              fontFamily: 'Bold'),
        ),
      ),
    );
  }
}
