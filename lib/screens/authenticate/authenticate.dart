import 'package:igea_app/screens/authenticate/register.dart';
import 'package:igea_app/screens/authenticate/sign_in.dart';
import 'package:igea_app/screens/authenticate/reset.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  String showScreen = 'sign in';

  void toggleView(String showScreen) {
    setState(() => this.showScreen = showScreen);
  }

  @override
  Widget build(BuildContext context) {
    if (showScreen == 'sign in') {
      return SignIn(toggleView: toggleView);
    } else if (showScreen == 'register'){
      return Register(toggleView: toggleView);
    } else {
      return Reset(toggleView: toggleView);
    }
  }
}