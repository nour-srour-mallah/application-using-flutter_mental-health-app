import 'package:flutter/material.dart';

import '../../resources/color-manager.dart';

class TextfieldAddTask extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const TextfieldAddTask({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        cursorColor: ColorManager.buttonBase,
        style: TextStyle(
          color: ColorManager.textFielTextBase,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.appBarBase,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.appBarBase,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.secondPanicAttack,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: label,
          labelStyle: TextStyle(color: ColorManager.textFielTextBase),
          filled: true,
          fillColor: ColorManager.textFieldBase,
        ),
      ),
    );
  }
}
