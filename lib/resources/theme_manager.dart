import 'color-manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';

import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //******* need to add more color and fontsize
    //text theme

    textTheme: TextTheme(
        //bold
        bodyMedium: getBoldStyle(
          color: ColorManager.white,
          fontsize: FontSize.fs5,
        ),
        //semibold
        headlineLarge: getSemiBoldStyle(
          color: ColorManager.white,
          fontsize: FontSize.fs5,
        ),
        //medium
        titleMedium: getMediumStyle(
          color: ColorManager.white,
          fontsize: FontSize.fs5,
        ),
        bodyLarge: getRegularStyle(color: ColorManager.primaryBase),
        bodySmall: getRegularStyle(color: ColorManager.primaryBase)),
  );
}
