import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryBase = const Color.fromARGB(255, 210, 210, 210);
  static Color elementBase = Color.fromARGB(255, 208, 201, 201);
  static Color appBarBase = const Color.fromARGB(255, 133, 129, 132);
  static Color secondBase = const Color.fromARGB(228, 140, 152, 172);
  static Color textFieldBase = const Color.fromARGB(255, 233, 233, 233);
  static Color textFielTextBase = const Color.fromARGB(255, 72, 72, 72);
  static Color buttonBase = const Color.fromARGB(255, 62, 62, 62);
  static Color white = const Color.fromARGB(255, 255, 255, 255);

  // color for panic attacks
  static Color primaryPanicAttack = Color.fromARGB(255, 178, 177, 230);
  static Color secondPanicAttack = Color.fromARGB(255, 77, 76, 125);
  static Color appBarPanicAttack = Color.fromARGB(255, 130, 130, 167);
  static Color sectioHeaderPanicAttack = Color.fromARGB(98, 77, 76, 125);
  static Color elementPanicAttack = Color.fromARGB(255, 198, 197, 228);
  static Color textFieldPanicAttack = Color.fromARGB(255, 223, 223, 233);
  static Color ansPanicAttack = Color.fromARGB(255, 88, 88, 128);
  static Color quesPanicAttack = Color.fromARGB(255, 85, 84, 130);

  //for make edit

  static Map<String, Color> getColorScheme(String userType) {
    if (userType == "doctor") {
      return {
        'primary': primaryBase,
        'element': elementBase,
        'appBar': appBarBase,
        'second': secondBase,
        'textField': textFieldBase,
        'textFieldText': textFielTextBase,
        'button': buttonBase,
        'white': white,
      };
    } else {
      return {
        'primary': primaryPanicAttack,
        'element': elementPanicAttack,
        'appBar': appBarPanicAttack,
        'second': secondPanicAttack,
        'textField': textFieldPanicAttack,
        'textFieldText': ansPanicAttack,
        'button': quesPanicAttack,
        'white': white,
      };
    }
  }
}
