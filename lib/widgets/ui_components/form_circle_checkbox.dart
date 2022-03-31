import 'package:flutter/material.dart';

class FormCircleCheckbox extends StatelessWidget {
  const FormCircleCheckbox({Key key, this.filledColor}) : super(key: key);

  final Color filledColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.white, //Color(0xFFE8B21C),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: filledColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    );
  }
}
