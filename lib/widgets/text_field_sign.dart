import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/sign_up/sign_up_controller.dart';
import '../resources/color-manager.dart';

class TextFieldSign extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;

  const TextFieldSign({
    Key? key,
    required this.icon,
    required this.hint,
    required this.controller,
    this.inputFormatters,
    this.validator,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChange,
        obscureText: hint == "enter your password",
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.secondBase),
            borderRadius: BorderRadius.circular(25),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.secondBase),
            borderRadius: BorderRadius.circular(25),
          ),
          filled: true,
          fillColor: ColorManager.textFieldBase,
          prefixIcon: Icon(
            icon,
            color: ColorManager.textFielTextBase,
          ),
          hintText: hint,
          hintStyle: TextStyle(color: ColorManager.textFielTextBase),
        ),
        cursorColor: ColorManager.textFielTextBase,
      ),
    );
  }
}

class TextFieldBirth extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller.birthController,
        readOnly: true,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(25)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.secondBase,
                ),
                borderRadius: BorderRadius.circular(25)),
            filled: true,
            fillColor: ColorManager.textFieldBase,
            prefixIcon: Icon(
              Icons.cake,
              color: ColorManager.textFielTextBase,
            ),
            hintText: "enter your birth",
            hintStyle: TextStyle(color: ColorManager.textFielTextBase)),
        cursorColor: ColorManager.textFielTextBase,
        onTap: () => controller.selectDate(context),
      ),
    );
  }
}
