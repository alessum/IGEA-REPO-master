import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';

class PrevengoOnboardingSimpleParentButton extends StatelessWidget {
  const PrevengoOnboardingSimpleParentButton({
    Key key,
    @required this.label,
    @required this.iconPath,
    @required this.isChecked,
    @required this.onTap,
  }) : super(key: key);

  final String label;
  final String iconPath;
  final bool isChecked;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: media.width * 0.4,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isChecked ? ConstantsGraphics.COLOR_ONBOARDING_YELLOW : Color(0xFFEEE7D0),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              iconPath,
              height: media.height * 0.045,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Bold',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
