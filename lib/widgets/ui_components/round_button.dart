import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
    @required this.child,
    @required this.color,
    this.coefHeight,
    this.coefWidth,
    this.padding
  }) : super(key: key);

  final Widget child;
  final Color color;
  final double coefWidth;
  final double coefHeight;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      height: media.height * (coefHeight ?? 0.06),
      width: media.width * (coefWidth ?? 0.3),
      padding: padding ?? EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: child,
    );
  }
}
