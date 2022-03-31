import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:flutter_svg/svg.dart';

class CouponTicket extends StatelessWidget {
  const CouponTicket({
    Key key,
    this.heightFactor,
    @required this.brand,
    @required this.code,
    @required this.logoImage,
    @required this.value,
  }) : super(key: key);

  final double heightFactor;
  final String brand;
  final String code;
  final String logoImage;
  final double value;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      // height: media.height * (heightFactor ?? 0.56),
      width: media.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xddF5f5f5),
      ),
      child: Column(
        children: [
          SizedBox(height: media.height * 0.01),
          Text(
            brand,
            style: TextStyle(
                color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                fontFamily: 'Gotham',
                fontSize: media.width * 0.07),
          ),
          SizedBox(
            height: media.height * 0.01,
          ),
          SvgPicture.asset(
            'assets/icons/qr-amazon-it.svg',
            height: media.height * 0.324,
          ),
          SizedBox(
            height: media.height * 0.02,
          ),
          Text(
            code,
            style:
                TextStyle(fontFamily: 'Gotham', fontSize: media.width * 0.05),
          ),
          SizedBox(
            height: media.height * 0.02,
          ),
          Container(
            height: media.height * 0.008,
            width: media.width * 0.9,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1000,
              itemBuilder: (context, _) {
                return Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                logoImage,
                width: media.width * 0.25,
              ),
              Container(
                height: media.height * 0.105,
                width: media.height * 0.008,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 100,
                  itemBuilder: (context, _) {
                    return Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: media.width * 0.5,
                child: RichText(
                  text: TextSpan(
                    text: '¤ ' + value.toString(),
                    style: TextStyle(
                        // color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                        color: Colors.black,
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.05),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' su un\n acquisto di',
                        style: TextStyle(
                            // color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                            color: Colors.black,
                            fontFamily: 'Light',
                            fontSize: media.width * 0.05,
                            height: media.width * .004),
                      ),
                      TextSpan(
                        text: ' ¤ 20',
                        style: TextStyle(
                            // color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                            color: Colors.black,
                            fontFamily: 'Gotham',
                            fontSize: media.width * 0.05),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
