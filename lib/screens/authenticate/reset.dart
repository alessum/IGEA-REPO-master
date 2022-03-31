import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/services/auth.dart';
import 'package:igea_app/shared/constants.dart';
import 'package:igea_app/shared/loading.dart';

class Reset extends StatefulWidget {
  final Function toggleView;
  Reset(
      {this.toggleView}); // the constructor goes inside the Widget, not the state

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String message = '';
  Color messageColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: colorAuthScreens,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: media.height * 0.1),
                        SvgPicture.asset(
                          'assets/logo/logo.svg',
                          width: media.width * .4,
                        ),
                        SizedBox(height: media.height * 0.05),
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                media.width * .15,
                                media.height * 0.1,
                                media.width * .15,
                                media.height * 0.1),
                            padding: EdgeInsets.symmetric(
                                horizontal: media.width * .03,
                                vertical: media.width * 0.02),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Email'),
                                  validator: (val) => val.isEmpty
                                      ? 'Inserisci l\'indirizzo email di cui non ricordi la password'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  style: TextStyle(
                                    fontFamily: 'Book',
                                    fontSize: media.width * 0.04,
                                    color:
                                        ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                                  ),
                                ),
                                SizedBox(height: media.height * 0.03),
                                RaisedButton(
                                  elevation: 0.0,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      dynamic result = await _auth
                                          .sendPasswordResetEmail(email);
                                      if (result == null) {
                                        setState(() {
                                          message =
                                              'Un link per il recupero della password è stato inviato all\'indirizzo $email';
                                          messageColor = Colors.green;
                                          loading = false;
                                        });
                                      } else {
                                        setState(() {
                                          message = result;
                                          messageColor = Colors.red;
                                          loading = false;
                                        });
                                      }
                                    }
                                  },
                                  //textColor: Colors.black,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(48.0),
                                  ),
                                  padding: EdgeInsets.all(0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xfff7c433),
                                      borderRadius: BorderRadius.circular(48.0),
                                    ),
                                    padding: EdgeInsets.all(media.width * 0.03),
                                    child: Text('recupera password',
                                        style: TextStyle(
                                            fontSize: media.width * 0.04,
                                            color: Colors.white,
                                            fontFamily: 'Gotham')),
                                  ),
                                ),
                                SizedBox(height: media.height * 0.005),
                                Text(
                                  message,
                                  style: TextStyle(
                                      color: messageColor,
                                      fontFamily: 'Book',
                                      fontSize: media.width * 0.035),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: media.height * 0.02),
                    _LoginButton(widget: widget, media: media),
                  ],
                ),
              ),
            ));
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key key,
    @required this.widget,
    @required this.media,
  }) : super(key: key);

  final Reset widget;
  final Size media;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0.0,
      onPressed: () {
        widget.toggleView(
            'sign in'); // no this.toggleView, perchè this si riferisce allo stato
      },
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(48.0),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff0C63A6),
          borderRadius: BorderRadius.circular(48.0),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: media.width * 0.053, vertical: media.height * 0.015),
        child: Text('Accedi',
            style: TextStyle(
                fontSize: media.width * 0.05,
                color: Colors.white,
                fontFamily: 'Gotham')),
      ),
    );
  }
}
