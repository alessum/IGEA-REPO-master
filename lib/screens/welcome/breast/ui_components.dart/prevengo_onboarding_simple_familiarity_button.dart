import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';

class PrevengoOnboardingSimpleFamiliarityButton extends StatelessWidget {
  const PrevengoOnboardingSimpleFamiliarityButton({
    Key key,
    @required this.label,
    @required this.isChecked,
    @required this.onTap,
  }) : super(key: key);

  final String label;
  final bool isChecked;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        // width: media.width * 0.4,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isChecked
              ? ConstantsGraphics.COLOR_ONBOARDING_YELLOW
              : Color(0xFFEEE7D0),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: media.width * 0.05,
              fontFamily: 'Bold',
            ),
          ),
        ),
      ),
    );
  }
}
