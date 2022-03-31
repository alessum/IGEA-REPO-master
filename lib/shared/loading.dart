import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:igea_app/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorAuthScreens,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.blue[900],
          size: 50.0,
        )
      )
    );
  }
}