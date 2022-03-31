import 'package:flutter/material.dart';

class PrevengoRadioButtonText extends StatelessWidget {
  const PrevengoRadioButtonText({
    Key key,
    @required this.label,
    @required this.checked,
    @required this.onTap,
    @required this.colorTheme,
    @required this.width,
    @required this.fontSize,
  }) : super(key: key);

  final String label;
  final Color colorTheme;
  final bool checked;
  final double width;
  final double fontSize;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(8),
        width: width,
        decoration: BoxDecoration(
          color: colorTheme,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            color: checked ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontFamily: 'Bold'),
        ),
      ),
    );
  }
}
