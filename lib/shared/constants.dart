import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';

// const colorAuthScreens = Color(0xff54BBE7);
const colorAuthScreens = Color(0xffF2F4F4);

const textInputDecoration = InputDecoration(
  errorMaxLines: 2,
  fillColor: Color(0xddFFFFFF),
  filled: true,
  hintStyle: TextStyle(
      color: ConstantsGraphics.COLOR_ONBOARDING_BLUE, fontFamily: 'Light'),
  enabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      const Radius.circular(30.0),
    ),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: ConstantsGraphics.COLOR_ONBOARDING_BLUE, width: 1.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(30.0),
    ),
  ),
);

const textInputDecorationRegistryScreen = InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    border: InputBorder.none,
    errorMaxLines: 2,
    fillColor: Color(
        0xFF5C88C1), //FIXME SISTEMARE CON CODICE ESADECIMALE DEL COLORE PIù CHIARO
    filled: true,
    hintStyle: TextStyle(color: Colors.white, fontFamily: 'Light'),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: Colors.white, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW, width: 3.0),
      borderRadius: const BorderRadius.all(
        const Radius.circular(30.0),
      ),
    ));

const textInputDecorationMedicalInfoScreen = InputDecoration(
  contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 15.0),
  errorMaxLines: 1,
  fillColor: Color(0xFF5C88C1),
  filled: true,
  hintStyle: TextStyle(color: Colors.white, fontFamily: 'Light'),
  enabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      const Radius.circular(30.0),
    ),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(30.0),
    ),
  ),
);
