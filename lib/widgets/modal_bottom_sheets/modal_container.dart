import 'package:flutter/material.dart';

class ModalContainer extends StatelessWidget {
  const ModalContainer({
    Key key,
    @required this.child,
    this.coefHeight,
    this.color,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final double coefHeight;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: padding ?? EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: child,
    );
  }
}
