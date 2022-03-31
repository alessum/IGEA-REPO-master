import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/constant.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  final String shadow;
  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.030),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.height * 0.030),
          boxShadow: [
            BoxShadow(
              offset: Offset(100, 0), //? non ho capito perchè non funziona
              blurRadius: 60,
              spreadRadius: 40,
              color: Colors.black,
            ),
          ],
        ),
        child: Material(
          color: light_Button,
          child: InkWell(
            splashColor: Colors.black12.withOpacity(0.6),
            highlightColor: Colors.black12.withOpacity(0.4),
            onTap: press,
            child: Stack(
              children: [
                Positioned(
                  bottom: -2,
                  left: 0,
                  child: SvgPicture.asset(
                    shadow,
                    width: size.height * 0.250,
                    // color: Colors.green[400],
                  ),
                ),
                Positioned(
                  top: size.height * 0.022,
                  left: size.width * 0.040,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        color: kMenuText,
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.04,
                  right: size.width * 0.04,
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height * 0.040,
                    width: size.height * 0.040,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(svgSrc,
                        height: size.height * 0.04, color: kActiveIconColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
