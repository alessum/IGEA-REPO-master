import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_chatbot.dart';

import 'package:igea_app/blocs/bloc_onboarding.dart';
import 'package:igea_app/blocs/onboarding/onboarding_registry_bloc.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_chatbot_messages.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/gender.dart';

import 'package:igea_app/screens/registry/registry_text_form_field.dart';
import 'package:igea_app/services/chatbot_manager.dart';
import 'package:igea_app/services/utilities.dart';

import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_calc_cf.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_calc_cf_missing_value.dart';

import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_missing_values.dart';
import 'package:igea_app/widgets/ui_components/button_rounded_confirmation.dart';

import 'package:igea_app/widgets/ui_components/registry_input_birthday.dart';
import 'package:igea_app/widgets/ui_components/registry_input_fiscal_code.dart';
import 'package:igea_app/widgets/ui_components/registry_input_gender.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'ui_components/prevengo_registry_modal_info.dart';

class RegistryDataScreen extends StatefulWidget {
  RegistryDataScreen({
    Key key,
  }) : super(key: key);

  @override
  _RegistryDataScreenState createState() => _RegistryDataScreenState();
}

class _RegistryDataScreenState extends State<RegistryDataScreen> {
  final FocusScopeNode _node = FocusScopeNode();

  bool loading = false;

  // text field state
  String _username;
  String _name;
  String _surname;
  String _dateOfBirthString;
  DateTime _dateOfBirth;

  String birthPlace;
  Gender _gender;
  String _fiscalCode;
  bool _autocompleteFiscalCodeFlag;
  TextEditingController dateController = TextEditingController();
  TextEditingController birthplaceController = TextEditingController();
  AutoCompleteTextField searchFieldText;

  String email = '';
  String password = '';
  String error = '';

  bool checkInputMale;
  bool checkInputFemale;

//per il bottone avanti:
  int arrow = 0;
  Color _colorbutton = Color(0xFF5C88C1);

  OnboardingRegistryBloc bloc;

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            bool flag =
                CacheManager.getValue(CacheManager.flagModalRegistry) ?? false;
            if (!flag) {
              showModalBottomSheet(
                context: context,
                builder: (context) => PrevengoRegistryModalInfo(),
                backgroundColor: Colors.black.withOpacity(0),
                isScrollControlled: true,
              );
              CacheManager.saveKV(CacheManager.flagModalRegistry, true);
            }
          });
        }));

    _loadData();
  }

  void _loadData() {
    _username = CacheManager.getValue(CacheManager.usernameKey) ?? '';
    _name = CacheManager.getValue(CacheManager.nameKey) ?? '';
    _surname = CacheManager.getValue(CacheManager.surnameKey) ?? '';
    _dateOfBirth = CacheManager.getValue(CacheManager.dateOfBirthKey);
    _dateOfBirthString = _dateOfBirth != null
        ? DateFormat('yMMMd', 'it').format(_dateOfBirth)
        : 'Data di nascita';
    _gender = CacheManager.getValue(CacheManager.genderKey);
    _fiscalCode = CacheManager.getValue(CacheManager.fiscalCodeKey) ?? '';
    _autocompleteFiscalCodeFlag = false;
  }

  Future<String> createBirthplaceAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // shape: Rou,
            title: Text(
              'Inserisci il Comune di nascita',
              style: TextStyle(
                  fontFamily: 'Gotham',
                  color: Colors.black,
                  fontSize: 18.0,
                  height: 1.2),
            ),
            content: TextField(controller: birthplaceController),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Fatto'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(birthplaceController.text.toString());
                },
              ),
            ],
          );
        });
  }

  // void _buildBirthPlaceModal(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => ModalRegistryCalcFiscalCode(
  //             suggestedCityList: bloc.suggestedCityList,
  //             setFiscalCode: (value) {
  //               setState(() {
  //                 // SharedPreferencesManager.saveKV(
  //                 //     SharedPreferencesManager.fiscalCodeKey, value);
  //                 _autocompleteFiscalCodeFlag = true;
  //                 _fiscalCode = value;
  //                 print('Fiscal Code' + _fiscalCode);
  //               });
  //               Navigator.pop(context);
  //             },
  //             registryValues: {
  //               Constants.REGISTRY_SURNAME_KEY: _surname,
  //               Constants.ORGAN_NAME_KEY: _name,
  //               Constants.REGISTRY_DATE_OF_BIRTH_KEY: _dateOfBirth,
  //               Constants.REGISTRY_GENDER_KEY: _gender,
  //             },
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingRegistryBlocProvider.of(context);
    //bloc.loadSuggestedCity();

    return Scaffold(
      backgroundColor: Color(0xff4373B1),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff4373B1),
        elevation: 0,
        toolbarHeight: media.height * 0.06,
        leadingWidth: media.width * .15,
        leading: GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(left: media.width * .05),
            child: SvgPicture.asset(
              'assets/icons/circle_left.svg',
              height: media.width * .1,
            ),
          ),
        ),
        title: Text(
          'Dati Anagrafici',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Gotham',
            fontSize: media.width * .07,
          ),
        ),
      ),
      body: buildRegistryPage(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatbotBlocProvider(
              child: Chatbot(
                suggestedMessageList:
                    ConstantsChatbotMessages.ONBOARDING_REGISTRY_MESSAGES,
              ),
            ),
          ),
        ),
        child: SvgPicture.asset(
          'assets/avatars/arold_in_circle.svg',
          width: media.width * 0.2,
        ),
      ),
    );
  }

  Widget buildRegistryPage(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    SizedBox _formInputFieldSeparator =
        SizedBox(height: media.height < 700 ? 15 : 20.0);

    return Container(
      height: media.height,
      padding: EdgeInsets.only(top: media.height * .15),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(
                    media.width * 0.12, 0, media.width * 0.12, 0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RegistryTextFormField(
                      hintText: 'Soprannome',
                      initialValue: _username,
                      //focusScopeNode: _node,
                      setInputValue: (value) {
                        setState(() {
                          // SharedPreferencesManager.saveKV(
                          //     SharedPreferencesManager.usernameKey, value);
                          _username = value;
                        });
                      },
                    ),
                    _formInputFieldSeparator,
                    RegistryTextFormField(
                      hintText: 'Nome',
                      initialValue: _name,
                      //focusScopeNode: _node,
                      setInputValue: (value) {
                        setState(() {
                          _name = value;
                          // SharedPreferencesManager.saveKV(
                          //     SharedPreferencesManager.nameKey, value);
                        });
                      },
                    ),
                    SizedBox(
                      height: media.height < 700 ? 15 : 20.0,
                    ),
                    RegistryTextFormField(
                      hintText: 'Cognome',
                      initialValue: _surname,
                      //focusScopeNode: _node,
                      setInputValue: (value) {
                        setState(() {
                          _surname = value;
                          // SharedPreferencesManager.saveKV(
                          //     SharedPreferencesManager.surnameKey, value);
                        });
                      },
                    ),
                    _formInputFieldSeparator,
                    RegistryInputBirthdayClickAction(
                        setDateOfBirth: (value) {
                          setState(() {
                            _dateOfBirth = value;
                            _dateOfBirthString =
                                DateFormat('yMMMd', 'it').format(value);
                            // SharedPreferencesManager.saveKV(
                            //     SharedPreferencesManager.dateOfBirthKey,
                            //     _dateOfBirthString);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          });
                        },
                        initialDate: _dateOfBirthString),
                    _formInputFieldSeparator,
                    RegistryInputGenderClickAction(
                      setGender: (value) {
                        setState(() {
                          // SharedPreferencesManager.saveKV(
                          //     SharedPreferencesManager.genderKey,
                          //     value.index);
                          _gender = value;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      initalGenderValue: _gender != null ? _gender.index : -1,
                    ),
                    SizedBox(height: media.height * .31),
                    // RegitryInputFiscalCode(
                    //   autocomputeFiscalCode: _autocompleteFiscalCodeFlag,
                    //   hintText: 'Codice Fiscale',
                    //   initialValue: (() {
                    //     print('[CODICE FISCALE] ' + _fiscalCode);
                    //     return _fiscalCode;
                    //   }()),
                    //   //focusScopeNode: _node,
                    //   setInputValue: (value) {
                    //     setState(() {
                    //       // SharedPreferencesManager.saveKV(
                    //       //     SharedPreferencesManager.fiscalCodeKey, value);
                    //       _fiscalCode = value;
                    //       _autocompleteFiscalCodeFlag = false;
                    //     });
                    //   },
                    // ),
                    // SizedBox(height: media.height < 700 ? 3 : 5.0),
                    // RichText(
                    //   text: TextSpan(
                    //       text: 'non me lo ricordo',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 16,
                    //           decoration: TextDecoration.underline,
                    //           fontFamily: 'Book'),
                    //       recognizer: TapGestureRecognizer()
                    //         ..onTap = () {
                    //           print(_name);
                    //           print(_surname);
                    //           print(_dateOfBirthString);
                    //           print(_gender);
                    //           if (_name != '' &&
                    //               _surname != '' &&
                    //               _dateOfBirthString != null &&
                    //               _gender != null) {
                    //             _buildBirthPlaceModal(context);
                    //           } else {
                    //             _showCalcFiscalCodeProblem();
                    //           }
                    //         }),
                    // ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // if (_checkInputFields()) {
                  //   Map<String, dynamic> data = Map();
                  //   data.addAll({
                  //     Constants.REGISTRY_USERNAME_KEY: _username,
                  //     Constants.REGISTRY_NAME_KEY: _name,
                  //     Constants.REGISTRY_SURNAME_KEY: _surname,
                  //     Constants.REGISTRY_DATE_OF_BIRTH_KEY: _dateOfBirth,
                  //     Constants.REGISTRY_GENDER_KEY: _genderValue,
                  //     Constants.REGISTRY_FISCAL_CODE_KEY: _fiscalCode
                  //   });
                  //   bloc.inRegistryData.add(data);
                  //   widget.updateOnboarding(data);
                  //   widget.flashToPage(2);
                  // } else {
                  //   _showInputProblem(media);
                  // }
                  Map<String, dynamic> data = Map();
                  data.addAll({
                    Constants.REGISTRY_USERNAME_KEY: _username,
                    Constants.REGISTRY_NAME_KEY: _name,
                    Constants.REGISTRY_SURNAME_KEY: _surname,
                    Constants.REGISTRY_DATE_OF_BIRTH_KEY: _dateOfBirth,
                    Constants.REGISTRY_GENDER_KEY: _gender,
                    Constants.REGISTRY_FISCAL_CODE_KEY: _fiscalCode
                  });
                  // bloc.inRegistryData.add(data);
                  // CacheManager.saveMultipleKV({
                  //   CacheManager.usernameKey: _username,
                  //   CacheManager.nameKey: _name,
                  //   CacheManager.surnameKey: _surname,
                  //   CacheManager.dateOfBirthKey: _dateOfBirth,
                  //   CacheManager.genderKey: _gender,
                  //   CacheManager.genderKey: _gender,
                  // });
                },
                child: Container(
                  width: media.width * 0.5,
                  padding: EdgeInsets.all(media.width < 350 ? 5 : 8),
                  decoration: BoxDecoration(
                      color: _colorbutton,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                          style: BorderStyle.solid,
                          // color: _checkInputFields()
                          //     ? Colors.white
                          //     : Colors.grey[500])),
                          color: Colors.white)),
                  child: Center(
                    child: Text(
                      'Salva e continua',
                      style: TextStyle(
                          // color: _checkInputFields()
                          //     ? Colors.white
                          //     : Colors.grey[500],
                          color: Colors.white,
                          fontFamily: 'Bold',
                          fontSize: media.width * 0.05),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  void _showInputProblem(Size media) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0),
      builder: (_) => ModalBottomRegistryInputMissingValues(),
    );
  }

  void _showCalcFiscalCodeProblem() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black.withOpacity(0),
        builder: (_) => ModalBottomRegistryCalcCfMissingValue());
  }

  bool _checkInputFields() {
    if (_username.isNotEmpty &&
        _name.isNotEmpty &&
        _surname.isNotEmpty &&
        _dateOfBirthString.isNotEmpty &&
        _gender != null &&
        _fiscalCode.isNotEmpty)
      return true;
    else
      return false;
  }
}
