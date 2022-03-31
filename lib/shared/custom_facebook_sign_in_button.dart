import 'package:flutter/material.dart';


class CustomFacebookSignInButton extends StatelessWidget {

  final Function() onPressed;

  CustomFacebookSignInButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      color: Colors.white,
      splashColor: Colors.blue,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/external_png/facebook_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Accedi con Facebook',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}