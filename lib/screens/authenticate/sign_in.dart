import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/services/auth.dart';
import 'package:igea_app/shared/constants.dart';
import 'package:igea_app/shared/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:igea_app/shared/no_padding_checkbox.dart';
import 'package:igea_app/shared/custom_google_sign_in_button.dart';
import 'package:igea_app/shared/custom_facebook_sign_in_button.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(
      {this.toggleView}); // the constructor goes inside the Widget, not the state

  Future<void> saveEmailPreference(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }

  Future<String> getEmailPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email") ?? '';
    return email;
  }

  Future<void> savePasswordPreference(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("password", password);
  }

  Future<String> getPasswordPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString("password") ?? '';
    return password;
  }

  Future<void> saveCheckBoxValuePreference(bool checkBoxValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("checkBoxValue", checkBoxValue);
  }

  Future<bool> getCheckBoxValuePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkBoxValue = prefs.getBool("checkBoxValue") ?? false;
    return checkBoxValue;
  }

  Future<void> clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = false;

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  // text field state
  String email;
  String password;
  bool checkBoxValue;
  String error = '';

  Color _emailFormFieldBorderColor = Colors.red;
  Color _passwordFormFieldBorderColor = Colors.red;

  @override
  void initState() {
    widget.getEmailPreference().then(updateEmail);
    widget.getPasswordPreference().then(updatePassword);
    super.initState();
  }

  void updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  void updatePassword(String password) {
    setState(() {
      this.password = password;
    });
  }

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
                        SizedBox(height: media.height * 0.05),
                        SvgPicture.asset('assets/logo/logo.svg',
                            width: media.width * 0.35),
                        SizedBox(height: media.height * 0.05),
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(media.width * 0.02,
                                10.0, media.width * 0.02, 30.0),
                            padding: EdgeInsets.fromLTRB(media.width * 0.1,
                                10.0, media.width * 0.1, 0.0),
                            child: Column(
                              children: <Widget>[
                                FutureBuilder(
                                    future: widget.getEmailPreference(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return TextFormField(
                                          initialValue: snapshot.data,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () =>
                                              _node.nextFocus(),
                                          decoration:
                                              textInputDecoration.copyWith(
                                            hintText: 'Email',
                                            hintStyle: TextStyle(
                                                color: ConstantsGraphics
                                                    .COLOR_ONBOARDING_BLUE,
                                                fontFamily: 'Book',
                                                fontSize: media.width * 0.04),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      _emailFormFieldBorderColor,
                                                  width: 1.0),
                                            ),
                                          ),
                                          validator: (val) => val.isEmpty
                                              ? 'Inserisci un indirizzo email'
                                              : null,
                                          onChanged: (val) {
                                            setState(() {
                                              email = val;
                                              if (val.isNotEmpty) {
                                                _emailFormFieldBorderColor =
                                                    Colors.green;
                                              } else {
                                                _emailFormFieldBorderColor =
                                                    Colors.red;
                                              }
                                            });
                                          },
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                                SizedBox(height: media.height * 0.01),
                                FutureBuilder(
                                    future: widget.getPasswordPreference(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return TextFormField(
                                          initialValue: snapshot.data,
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(_node);
                                          },
                                          decoration:
                                              textInputDecoration.copyWith(
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                                color: ConstantsGraphics
                                                    .COLOR_ONBOARDING_BLUE,
                                                fontFamily: 'Book',
                                                fontSize: media.width * 0.04),
                                            suffixIcon: IconButton(
                                                onPressed: _toggleVisibility,
                                                icon: _isHidden
                                                    ? SvgPicture.asset(
                                                        'assets/icons/visibility_off.svg',
                                                        color:
                                                            Color(0xffaaaaaa),
                                                        width:
                                                            media.width * 0.06,
                                                      )
                                                    : SvgPicture.asset(
                                                        'assets/icons/visibility_on.svg',
                                                        color: ConstantsGraphics
                                                            .COLOR_ONBOARDING_BLUE,
                                                        width:
                                                            media.width * 0.06,
                                                      )),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      _passwordFormFieldBorderColor,
                                                  width: 1.0),
                                            ),
                                          ),
                                          obscureText: _isHidden,
                                          validator: (val) => val.length < 6
                                              ? 'Inserisci una password lunga almeno 6 caratteri'
                                              : null,
                                          onChanged: (val) {
                                            setState(() {
                                              password = val;
                                              if (val.length >= 6) {
                                                _passwordFormFieldBorderColor =
                                                    Colors.green;
                                              } else {
                                                _passwordFormFieldBorderColor =
                                                    Colors.red;
                                              }
                                            });
                                          },
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                                SizedBox(height: media.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: media.width * 0.05,
                                    ),
                                    FutureBuilder(
                                        future:
                                            widget.getCheckBoxValuePreference(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            checkBoxValue = snapshot.data;
                                            return NoPaddingCheckbox(
                                              value: checkBoxValue,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  checkBoxValue = value;
                                                  widget
                                                      .saveCheckBoxValuePreference(
                                                          value);
                                                });
                                              },
                                            );
                                          } else {
                                            return CircularProgressIndicator();
                                          }
                                        }),
                                    Text('ricordami',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: media.width * .04,
                                            fontFamily: 'Book')),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                RaisedButton(
                                  elevation: 0.0,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      if (checkBoxValue) {
                                        await widget
                                            .saveEmailPreference(this.email);
                                        await widget.savePasswordPreference(
                                            this.password);
                                        await widget
                                            .saveCheckBoxValuePreference(
                                                this.checkBoxValue);
                                      } else {
                                        await widget.clearPreferences();
                                      }
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              'Credenziali inserite non valide';
                                          loading = false;
                                        });
                                      }
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                  ),
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff0C63A6),
                                      borderRadius: BorderRadius.circular(48.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: media.width * 0.053,
                                        vertical: media.height * 0.015),
                                    child: Text('Accedi',
                                        style: TextStyle(
                                            fontSize: media.width * 0.05,
                                            color: Colors.white,
                                            fontFamily: 'Gotham')),
                                  ),
                                ),
                                SizedBox(height: media.height * 0.025),
                                RichText(
                                  text: TextSpan(
                                    text: 'problemi con l\'accesso?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: media.width * 0.025,
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Bold'),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        widget.toggleView(
                                            'reset'); // no this.toggleView, perchè this si riferisce allo stato
                                      },
                                  ),
                                ),
                                // SizedBox(height:0),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    error,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: media.width * 0.025),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: media.height * 0.05),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     CustomGoogleSignInButton(
                    //       onPressed: () async {
                    //         setState(() => loading = true);
                    //         dynamic result = await _auth.signInWithGoogle();
                    //         if (result == null) {
                    //           setState(() {
                    //             loading = false;
                    //           });
                    //         }
                    //       },
                    //     ),
                    //     SizedBox(
                    //       width: media.width*0.01,
                    //     )
                    //     CustomFacebookSignInButton(
                    //       onPressed: () async {
                    //         setState(() => loading = true);
                    //         dynamic result = await _auth.signInWithFacebook();
                    //         if (result == null) {
                    //           setState(() {
                    //             loading = false;
                    //           });
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: media.height * 0.05),
                    Text(
                      'non sei registrato?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Bold'),
                    ),
                    SizedBox(height: media.height * 0.01),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView(
                            'register'); // no this.toggleView, perchè this si riferisce allo stato
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff7c433),
                          borderRadius: BorderRadius.circular(48.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: media.width * 0.053,
                            vertical: media.height * 0.015),
                        child: Text('Registrati',
                            style: TextStyle(
                                fontSize: media.width * 0.05,
                                color: Colors.white,
                                fontFamily: 'Gotham')),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
