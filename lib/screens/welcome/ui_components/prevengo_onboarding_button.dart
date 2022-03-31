import 'package:flutter/material.dart';

class PrevengoOnboardingButton extends StatelessWidget {
  const PrevengoOnboardingButton({
    Key key,
    @required this.label,
    @required this.colorTheme,
    @required this.width,
    @required this.fontSize,
    @required this.onTap,
  }) : super(key: key);

  final String label;
  final Color colorTheme;
  final double width;
  final double fontSize;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
          child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        width: width,
        decoration: BoxDecoration(
            color: colorTheme,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              style: BorderStyle.solid,
              color: Colors.white,
              width: 1.5,
            )),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Gotham',
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
