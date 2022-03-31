import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';

class PrevengoOnboardingCounterParentButton extends StatelessWidget {
  const PrevengoOnboardingCounterParentButton({
    Key key,
    @required this.label,
    @required this.iconPath,
    @required this.counter,
    @required this.onAddTap,
    @required this.onRemoveTap,
  }) : super(key: key);

  final String label;
  final String iconPath;
  final String counter;
  final Function() onAddTap;
  final Function() onRemoveTap;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFEEE7D0),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: media.width * 0.02),
          Container(
            width: media.width * 0.07,
            child: SvgPicture.asset(
              iconPath,
              height: media.height * 0.045,
            ),
          ),
          SizedBox(width: media.width * 0.04),
          Container(
            width: media.width * 0.2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Bold',
              ),
            ),
          ),
          SizedBox(width: media.width * 0.12),
          Container(
            width: media.width * 0.05,
            child: Text(
              counter,
              style: TextStyle(
                fontSize: media.width * 0.08,
                fontFamily: 'Bold',
              ),
            ),
          ),
          SizedBox(width: media.width * 0.04),
          GestureDetector(
            onTap: () => onAddTap(),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: media.width * 0.07,
                  color: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                ),
              ),
            ),
          ),
          SizedBox(width: media.width * 0.02),
          GestureDetector(
            onTap: () => onRemoveTap(),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: media.width * 0.07,
                  color: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
