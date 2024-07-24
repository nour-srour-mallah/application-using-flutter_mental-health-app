import 'package:get/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidateController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ValidateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? "")) {
      return "email is not valid";
    }
    return null;
  }

  ValidatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return "password is not valid";
    }
    return null;
  }

  ValidateFname(String? fname) {
    if (fname?.isEmpty ?? true) {
      return "first name is empty";
    }
    return null;
  }

  ValidateLname(String? lname) {
    if (lname?.isEmpty ?? true) {
      return "last name is empty";
    }
    return null;
  }

  ValidateCountry(String? country) {
    if (country?.isEmpty ?? true) {
      return "country is empty";
    }
    return null;
  }

  Future onLogin(formKey) async {
    if (formKey.currentState!.validate()) {
      Get.snackbar("success", "Login Successful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 80, 102, 84));
      return;
    }
    Get.snackbar("Error", "Login Validation failed",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Color.fromARGB(255, 190, 83, 83));
    return;
  }

  Future onQuestions(formKey) async {
    if (formKey.currentState!.validate()) {
      Get.snackbar("success", "answer Questions Successful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 80, 102, 84));
      return;
    }
    Get.snackbar("Error", "answer Questions failed",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Color.fromARGB(255, 190, 83, 83));
    return;
  }

  Future onSignUp(formKey) async {
    if (formKey.currentState!.validate()) {
      Get.snackbar("success", "Sign Up Successful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 80, 102, 84));
      return;
    }
    Get.snackbar("Error", "Sign Up  Validation failed",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Color.fromARGB(255, 190, 83, 83));
    return;
  }
}
