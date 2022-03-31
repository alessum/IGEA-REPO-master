import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';

class PrevengoSingleRadioLabel extends StatelessWidget {
  const PrevengoSingleRadioLabel({
    Key key,
    @required this.onTap,
    @required this.isCheck,
    @required this.label,
  }) : super(key: key);

  final Function(bool value) onTap;
  final bool isCheck;
  final String label;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(!isCheck),
      child: Row(
        children: [
          Container(
            width: media.width * 0.07,
            height: media.width * 0.07,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: media.width * 0.07,
                    height: media.width * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                Center(
                  child: Container(
                    width: media.width * 0.05,
                    height: media.width * 0.05,
                    decoration: BoxDecoration(
                        color: isCheck ? ConstantsGraphics.COLOR_DIARY_BLUE : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: media.width * 0.02),
          Container(
            child: Text(
              label,
              style: TextStyle(
                fontSize: media.width * 0.045,
                fontFamily: 'Book',
              ),
            ),
          )
        ],
      ),
    );
  }
}
