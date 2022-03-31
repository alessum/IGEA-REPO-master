import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/modal_container.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:igea_app/widgets/ui_components/round_button.dart';

class ModalBottomConfirmation extends StatelessWidget {
  const ModalBottomConfirmation({
    Key key,
    @required this.confirmationLabel,
    @required this.onPress,
    this.agreeButtonColor,
    this.disagreeButtonColor,
  }) : super(key: key);

  final String confirmationLabel;
  final Function(bool isYesButtonPressed) onPress;

  final Color agreeButtonColor;
  final Color disagreeButtonColor;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return ModalContainer(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          CloseLineTopModal(color: Colors.grey[600]),
          SizedBox(height: media.height * .02),
          Container(
            child: Text(
              confirmationLabel,
              style: TextStyle(
                fontSize: media.width * 0.055,
                fontFamily: 'Bold',
              ),
            ),
          ),
          SizedBox(height: media.height * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => onPress(true),
                child: RoundButton(
                  child: Center(
                    child: Text(
                      'Si',
                      style: TextStyle(
                        fontSize: media.width * 0.05,
                        fontFamily: 'Book',
                      ),
                    ),
                  ),
                  color: agreeButtonColor ?? ConstantsGraphics.COLOR_DIARY_BLUE,
                ),
              ),
              GestureDetector(
                onTap: () => onPress(false),
                child: RoundButton(
                  child: Center(
                    child: Text(
                      'No',
                      style: TextStyle(
                        fontSize: media.width * 0.05,
                        fontFamily: 'Book',
                      ),
                    ),
                  ),
                  color:
                      disagreeButtonColor ?? ConstantsGraphics.COLOR_DIARY_BLUE,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
