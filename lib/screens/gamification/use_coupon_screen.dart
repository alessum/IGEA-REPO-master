import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:igea_app/widgets/ui_components/coupon_ticket.dart';

class UseCouponsScreen extends StatelessWidget {
  const UseCouponsScreen({
    Key key,
    @required this.code,
    @required this.brand,
    @required this.logoImage,
    @required this.value,
  }) : super(key: key);

  final String code;
  final String brand;
  final String logoImage;
  final double value;

  final String title = 'Amazon';
  final int euros = 5;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text('Prevenzione primaria',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: media.width * 0.07,
                  color: Colors.black,
                  fontFamily: 'Gotham')),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.only(
            top: media.height * 0.01,
            bottom: media.height * 0.02,
          ),
          decoration: BoxDecoration(
            color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(80),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              CloseLineTopModal(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    fit: FlexFit.loose,
                    child: ListTile(
                      leading: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            'assets/icons/circle_left.svg',
                            width: media.width * 0.09,
                          )),
                      title: Text('Usa il coupon',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: media.width * 0.07,
                              color: Colors.white,
                              fontFamily: 'Gotham')),
                    ),
                  ),
                ],
              ),
              CouponTicket(
                brand: brand,
                code: code,
                logoImage: logoImage,
                value: value,
              ),
              SizedBox(height: media.height * 0.08,),
              Container(
                width: media.width * 0.9,
                padding: EdgeInsets.all(media.width * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xddF5f5f5),
                ),
                child: Center(
                  child: Text(
                    'Utilizza coupon',
                    style: TextStyle(
                        fontSize: media.width * 0.06, fontFamily: 'Gotham'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
