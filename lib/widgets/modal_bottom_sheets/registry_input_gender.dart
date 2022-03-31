import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/widgets/ui_components/button_radio_text_container.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class ModalBottomInputGender extends StatefulWidget {
  ModalBottomInputGender({
    Key key,
    @required this.setGender,
  }) : super(key: key);

  final Function(Gender gender) setGender;

  @override
  _ModalBottomInputGenderState createState() => _ModalBottomInputGenderState();
}

class _ModalBottomInputGenderState extends State<ModalBottomInputGender> {
  bool btnMaleCheck = false;
  bool btnFemaleCheck = false;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CloseLineTopModal(),
          SizedBox(height: media.height * .02),
          Text(
            'Seleziona il sesso',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Book',
                color: Colors.black),
          ),
          SizedBox(height: media.height * .02),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      btnMaleCheck = true;
                      btnFemaleCheck = false;
                    });
                    widget.setGender(Gender.MALE);
                  },
                  child: ButtonRadioTextContainer(
                    label: 'Maschio',
                    checked: btnMaleCheck,
                    nonCheckedColor: Colors.grey[500],
                    checkedColor: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                  ),
                ),
                SizedBox(
                  width: 0.1,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      btnMaleCheck = false;
                      btnFemaleCheck = true;
                    });
                    widget.setGender(Gender.FEMALE);
                  },
                  child: ButtonRadioTextContainer(
                    label: 'Femmina',
                    checked: btnFemaleCheck,
                    nonCheckedColor: Colors.grey[500],
                    checkedColor: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: media.height * .02),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: media.width * .8,
              padding: EdgeInsets.symmetric(
                  vertical: media.width * .02, horizontal: media.width * .05),
              decoration: BoxDecoration(
                  color: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Text(
                'Conferma',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: media.width * .05,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
