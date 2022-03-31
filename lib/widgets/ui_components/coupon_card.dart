import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    Key key,
    @required this.title,
    @required this.value,
    @required this.logoImage,
    @required this.onTap,
    @required this.buttonLabel,
  }) : super(key: key);

  final String title;
  final String logoImage;
  final double value;
  final String buttonLabel;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Container(
      width: media.width * 0.85,
      height: media.height * 0.2,
      padding: EdgeInsets.fromLTRB(20, 12, 20, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
        border:
            Border.all(style: BorderStyle.solid, color: Colors.white, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                width: media.width * 0.4,
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Book',
                      fontSize: media.width * 0.05,
                      color: Colors.black),
                )),
            Container(
                child: Text(
              "¤ " + value.toString(),
              style: TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: media.width * 0.07,
                  color: Colors.black),
            ))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                logoImage,
                height: media.height * 0.05,
              ),
              GestureDetector(
                onTap: () => onTap(),
                child: Container(
                  width: media.width * 0.3,
                  padding: EdgeInsets.fromLTRB(13, 10, 13, 10),
                  decoration: BoxDecoration(
                      color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  child: Center(
                    child: Text(
                      buttonLabel,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bold',
                        fontSize: media.width * 0.05,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
