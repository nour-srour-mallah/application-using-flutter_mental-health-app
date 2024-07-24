import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontfamily,
      color: color,
      fontWeight: fontWeight);
}

//************   remembbberr need to change fontsize *********
//when you call this class need just give color and size with FontSize.fs..
//regular
TextStyle getRegularStyle(
    {double fontsize = FontSize.fs12, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.Regular, color);
}

//bold
TextStyle getBoldStyle({double fontsize = FontSize.fs5, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.Bold, color);
}

//medium
TextStyle getMediumStyle(
    {double fontsize = FontSize.fs12, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.Medium, color);
}

//SemiBold
TextStyle getSemiBoldStyle(
    {double fontsize = FontSize.fs5, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.SemiBold, color);
}

//Light
TextStyle getLightStyle(
    {double fontsize = FontSize.fs12, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.Light, color);
}
