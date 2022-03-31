import 'package:flutter/material.dart';

class PrevengoTextFieldRound extends StatelessWidget {
  const PrevengoTextFieldRound({
    Key key,
    this.widthRatio,
    @required this.onChanged,
    @required this.hintText,
  }) : super(key: key);

  final double widthRatio;
  final String hintText;
  final Function(String text) onChanged;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      width: media.width * (widthRatio ?? 0.3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: TextField(
        onChanged: (text) => onChanged(text),
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
               const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15)),
        readOnly: false,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}
