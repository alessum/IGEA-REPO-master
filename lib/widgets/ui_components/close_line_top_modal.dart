import 'package:flutter/material.dart';

class CloseLineTopModal extends StatelessWidget {
  const CloseLineTopModal({Key key, this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      height: 5,
      width: media.width * 0.25,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[600],
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
