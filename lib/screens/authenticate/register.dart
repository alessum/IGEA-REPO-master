import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/screens/registry/registry_text_form_field.dart';
import 'package:igea_app/services/auth.dart';
import 'package:igea_app/shared/constants.dart';
import 'package:igea_app/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register(
      {this.toggleView}); // the constructor goes inside the Widget, not the state

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuthService _auth = FirebaseAuthService();

  bool loading = false;

  bool _isHidden = true;

  // text field state
  String email = '';
  String password = '';
  String confirmedPassword = '';
  String error = '';

  // String initialValue;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmedPassword = TextEditingController();
  // AutoCompleteTextField searchFieldText;

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _email.text = email;
    _password.text = password;
    _confirmedPassword.text = confirmedPassword;
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  TextEditingController dateController = TextEditingController();
  Color _emailFormFieldBorderColor = ConstantsGraphics.COLOR_ONBOARDING_BLUE;
  Color _passwordFormFieldBorderColor = ConstantsGraphics.COLOR_ONBOARDING_BLUE;
  Color _confirmedPasswordFormFieldBorderColor =
      ConstantsGraphics.COLOR_ONBOARDING_BLUE;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    final node = FocusScope.of(context);

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: colorAuthScreens,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(height: media.height * 0.05),
                        SvgPicture.asset('assets/logo/logo.svg',
                            width: media.width * 0.35),
                        SizedBox(height: media.height * 0.05),
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                media.width * 0.02,
                                media.height * 0.01,
                                media.width * 0.02,
                                media.height * 0.03),
                            padding: EdgeInsets.fromLTRB(media.width * 0.1,
                                media.height * 0.01, media.width * 0.1, 0.0),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _email,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  decoration: textInputDecoration.copyWith(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color: ConstantsGraphics
                                            .COLOR_ONBOARDING_BLUE,
                                        fontFamily: 'Book',
                                        fontSize: media.width * 0.04),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _emailFormFieldBorderColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                  validator: (val) => val.isEmpty
                                      ? 'Questo campo è obbligatorio'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                      if (val.isNotEmpty) {
                                        _emailFormFieldBorderColor =
                                            Colors.green;
                                      } else {
                                        _emailFormFieldBorderColor = Colors.red;
                                      }
                                    });
                                  },
                                ),
                                SizedBox(height: media.height * 0.01),
                                TextFormField(
                                  controller: _password,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  decoration: textInputDecoration.copyWith(
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
                                                color: Color(0xffaaaaaa),
                                                width: media.width * 0.06,
                                              )
                                            : SvgPicture.asset(
                                                'assets/icons/visibility_on.svg',
                                                color: ConstantsGraphics
                                                    .COLOR_ONBOARDING_BLUE,
                                                width: media.width * 0.06,
                                              )),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _passwordFormFieldBorderColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                  obscureText: _isHidden,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Questo campo è obbligatorio';
                                    } else if (val.isNotEmpty &&
                                        val.length < 6) {
                                      return 'Inserisci una password lunga almeno 6 caratteri';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                      if (val.length >= 6) {
                                        _passwordFormFieldBorderColor =
                                            Colors.green;
                                        if (val == this.confirmedPassword) {
                                          _confirmedPasswordFormFieldBorderColor =
                                              Colors.green;
                                        } else {
                                          _confirmedPasswordFormFieldBorderColor =
                                              Colors.red;
                                        }
                                      } else {
                                        _passwordFormFieldBorderColor =
                                            Colors.red;
                                        _confirmedPasswordFormFieldBorderColor =
                                            Colors.red;
                                      }
                                    });
                                  },
                                ),
                                SizedBox(height: media.height * 0.01),
                                TextFormField(
                                  controller: _confirmedPassword,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  decoration: textInputDecoration.copyWith(
                                    hintText: 'Conferma password',
                                    hintStyle: TextStyle(
                                        color: ConstantsGraphics
                                            .COLOR_ONBOARDING_BLUE,
                                        fontFamily: 'Book',
                                        fontSize: media.width * 0.04),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _confirmedPasswordFormFieldBorderColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: (val) {
                                    if (val != this.password &&
                                        val.isNotEmpty) {
                                      return 'Le password non coincidono';
                                    } else if (val.isEmpty) {
                                      return 'Questo campo è obbligatorio';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      confirmedPassword = val;
                                      if (val == this.password &&
                                          val.isNotEmpty) {
                                        setState(() =>
                                            _confirmedPasswordFormFieldBorderColor =
                                                Colors.green);
                                      } else {
                                        setState(() =>
                                            _confirmedPasswordFormFieldBorderColor =
                                                Colors.red);
                                      }
                                    });
                                  },
                                ),
                                SizedBox(height: media.height * 0.01),
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: media.width * 0.035,
                                      fontFamily: 'Book'),
                                ),
                                SizedBox(height: media.height * 0.02),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      dynamic result = await _auth
                                          .registerWithEmailAndPassword(
                                              email, password);
                                      print('[RESULT]' + result.toString());
                                      if (result == null) {
                                        setState(() {
                                          error = 'Indirizzo email non valido!';
                                          loading = false;
                                        });
                                      }
                                    }
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
                                SizedBox(height: media.height * 0.03),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'hai già un account?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: media.width * 0.03,
                          fontFamily: 'Bold'),
                    ),
                    SizedBox(
                      height: media.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView(
                            'sign in'); // no this.toggleView, perchè this si riferisce allo stato
                      },
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
                  ],
                ),
              ),
            )); //0xffF7CF24
  }
}
