import 'package:flutter/material.dart';

Color darkGreyColor = new Color(0xFF212128);

Color redColor = new Color(0xFFDC4F64);

Color lightBlueColor = new Color(0xFF8787A0);
Color whiteColor = new Color(0xFFFFFFFF);

MaterialColor whiteMaterial = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

TextStyle intrayTitleStyle = new TextStyle(
  fontFamily: 'Avenir',
  fontWeight: FontWeight.w700,
  color: darkGreyColor,
  fontSize: 40,
);

TextStyle bigLightBlueTitle = new TextStyle(
  fontFamily: 'Avenir',
  fontWeight: FontWeight.w700,
  color: lightBlueColor,
  fontSize: 40,
);

TextStyle darkTodoTitle = new TextStyle(
  fontFamily: 'Avenir',
  fontWeight: FontWeight.w700,
  color: darkGreyColor,
  fontSize: 30,
);

TextStyle redTodoTitle = new TextStyle(
  fontFamily: 'Avenir',
  fontWeight: FontWeight.w700,
  color: redColor,
  fontSize: 30,
);

TextStyle redBoldText = new TextStyle(
  fontFamily: 'Avenir',
  fontWeight: FontWeight.bold,
  color: redColor,
  fontSize: 20,
);

TextStyle redText = new TextStyle(
  fontFamily: 'Avenir',
  fontWeight: FontWeight.w100,
  color: redColor,
  
  fontSize: 20,
);