import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/services/utilities.dart';
import 'package:igea_app/widgets/ui_components/autocomplete_textfield_simple.dart';
import 'package:igea_app/widgets/ui_components/button_rounded_confirmation.dart';

class ModalRegistryCalcFiscalCode extends StatefulWidget {
  ModalRegistryCalcFiscalCode({
    Key key,
    @required this.suggestedCityList,
    @required this.setFiscalCode,
    @required this.registryValues,
  }) : super(key: key);

  final Map<String, dynamic> suggestedCityList;
  final Function(String fiscalCode) setFiscalCode;
  final Map<String,dynamic> registryValues;

  @override
  _ModalRegistryCalcFiscalCodeState createState() =>
      _ModalRegistryCalcFiscalCodeState();
}

class _ModalRegistryCalcFiscalCodeState
    extends State<ModalRegistryCalcFiscalCode> {
  String _birthPlace;
  List<String> _localSuggestedCityList = List();

  String _surname;
  String _name;
  DateTime _dateOfBirth;
  Gender _gender;


  @override
  void initState() {
    super.initState();
    widget.suggestedCityList.keys.forEach((key) {
      _localSuggestedCityList.add(key);
    });

    _surname = widget.registryValues[Constants.REGISTRY_SURNAME_KEY];
    _name = widget.registryValues[Constants.REGISTRY_NAME_KEY];
    _dateOfBirth = widget.registryValues[Constants.REGISTRY_DATE_OF_BIRTH_KEY];
    _gender = widget.registryValues[Constants.REGISTRY_GENDER_KEY];
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: media.height * 0.4,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 5),
            Text(
              'Inserisci il luogo di nascita',
              style:
                  TextStyle(fontFamily: 'Bold', fontSize: media.width * 0.05),
            ),
            AutocompleteTextFieldSimple(
              suggestions: _localSuggestedCityList,
              setBirthPlace: (value) {
                setState(() {
                  _birthPlace = value;
                });
              },
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.setFiscalCode(_calcFiscalCode());
                });
              },
              child: ButtonRoundedConfirmation(
                label: 'conferma',
                buttonColor: Color(0xFF5C88C1),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _calcFiscalCode() {
    String _fiscalCode = '';
    String consonants = 'BCDFGHJKLMNPQRSTVWXYZ';

    var c = 0, v = 0;
    String cons = '';
    String vows = '';

    //SURNAME
    _surname = _surname.toUpperCase();
  
    for (var i = 0; i < _surname.length; i++) {
      if (consonants.contains(_surname[i])) {
        if (_fiscalCode.length < 3) {
          _fiscalCode += _surname[i];
        }
        else {
          break;
        }
      }
      else {
        vows += _surname[i];
      }
    }

    while (_fiscalCode.length != 3) {
      if (v < vows.length) {
        _fiscalCode += vows[v++];
      }
      else {
        _fiscalCode += 'X';
      }
    }
  
    //NAME
    _name = _name.toUpperCase();
    vows = '';
  
    for (var i = 0; i < _name.length; i++) {
      if (consonants.contains(_name[i])) {
        cons += _name[i];
      }
      else {
        vows += _name[i];
      }
      if (cons.length == 4) {
        break;
      }
    }
  
    if (cons.length == 4) {
      _fiscalCode += cons[0];
      _fiscalCode += cons[2];
      _fiscalCode += cons[3];
    }
    else {
      while (_fiscalCode.length != 6) {
        if (c != cons.length) {
          _fiscalCode += cons[c++];
        }
        else if (v != vows.length) {
          _fiscalCode += vows[v++];
        }
        else {
          _fiscalCode += 'X';
        }
      }
    }

    //YEAR
    String year = _dateOfBirth.year.toString().substring(2);
    _fiscalCode += year;

    //MONTH
    int n = _dateOfBirth.month;
    String monthChars = 'ABCDEHLMPRST';
    _fiscalCode += monthChars[n - 1];

    //SEX AND DAY OF BIRTH
    int dayOfBirth = _dateOfBirth.day;
    if (_gender.index == Gender.FEMALE.index) {
      dayOfBirth += 40;
    }

    _fiscalCode += dayOfBirth.toString().padLeft(2, '0');

    //BIRTH PLACE DECODE
    String birthPlaceCode = widget.suggestedCityList[_birthPlace];
    _fiscalCode += birthPlaceCode;

    //CONTROL CHAR
    String controlChar = _computeControlChar(_fiscalCode);
    _fiscalCode += controlChar;

    return _fiscalCode;
  }

  String _computeControlChar(String cf) {
    int score = 0;
    for (int i = 0; i < cf.length; i++) {
      if (i % 2 != 0) {
        score += Constants.EVEN_CHAR_SCORE[cf[i]];
      } else {
        score += Constants.ODD_CHAR_SCORE[cf[i]];
      }
    }

    String controlCharKey = (score % 26).toString();
    return Constants.CONTROL_CHAR_DICT[controlCharKey];
  }
}
