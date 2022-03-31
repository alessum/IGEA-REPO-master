import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_uterus_hpvdna_modal_info.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_uterus_paptest_modal_info.dart';

class PrevengoOnboardingRadioButtonInfo extends StatelessWidget {
  const PrevengoOnboardingRadioButtonInfo({
    Key key,
    @required this.label,
    @required this.checked,
    @required this.checkColor,
    @required this.unCheckedColor,
    @required this.onTap,
    @required this.onInfoTap,
  }) : super(key: key);

  final String label;
  final bool checked;
  final Color checkColor, unCheckedColor;
  final Function() onTap;
  final Function() onInfoTap;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: media.width * 0.3,
                  height: media.height * 0.053,
                  decoration: BoxDecoration(
                      color: checked ? checkColor : unCheckedColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.white,
                          width: checked ? 3.5 : 1.5)),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          color: Colors.white,
                          fontSize: media.width * 0.04),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: media.width * 0.26,
              top: media.height * 0.013,
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => label.toUpperCase().contains('PAP')
                      ? PrevengoUterusPaptestModalInfo()
                      : PrevengoUterusHpvdnaModalInfo(),
                  backgroundColor: Colors.black.withOpacity(0),
                  isScrollControlled: true,
                ),
                child: SvgPicture.asset(
                  'assets/icons/info.svg',
                  width: media.width * 0.06,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
