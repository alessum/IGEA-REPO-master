import 'package:flutter/material.dart';


class CustomGoogleSignInButton extends StatelessWidget {

  final Function() onPressed;

  CustomGoogleSignInButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
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
            Image(image: AssetImage("assets/external_png/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Accedi con Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}