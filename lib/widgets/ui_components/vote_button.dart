import 'package:flutter/material.dart';

class VoteButton extends StatefulWidget {
  VoteButton({
    Key key,
    @required this.value,
    @required this.number,
    @required this.check,
  }) : super(key: key);

  final int value;
  final int number;
  final bool check;

  @override
  _VoteButtonState createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  @override
  Widget build(BuildContext context) {
    Color _dotcolor = widget.check ? Color(0xFF5C88C1) : Color(0xffCDCDCD);
    String _text = widget.check ? (widget.value + 1).toString() : '';

    Size media = MediaQuery.of(context).size;
    return Container(
      // padding: EdgeInsets.all(media.width * 0.0007),
      width: media.width * 0.05,
      height: media.width * 0.05,
      decoration: new BoxDecoration(
        color: _dotcolor,
        shape: BoxShape.circle,
        border: Border.all(
            style: BorderStyle.solid, color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: Text(_text,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gotham',
                fontSize: media.width * 0.03)),
      ),
    );
  }
}
