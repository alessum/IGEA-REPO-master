import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({Key key, @required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(12),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight, //-media.width * 0.006,
            child: SvgPicture.asset(
              'assets/avatars/arold_in_circle.svg',
              width: media.width * 0.15,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 15, left: 15),
              child: Bubble(
                margin: BubbleEdges.only(top: 10),
                radius: Radius.circular(25),
                nipHeight: 18,
                nip: BubbleNip.rightBottom,
                color: Color(0xffffffff),
                child: Container(
                  width: media.width * 0.65,
                  height: media.height * (0.15 + ((message.length - 67) * 0.001)),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: media.width * 0.045,
                          fontFamily: 'Book',
                        ),
                      ),
                      Text(
                        'Clicca in qualsiasi punto per continuare',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: media.width * 0.035,
                          fontFamily: 'Book',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
