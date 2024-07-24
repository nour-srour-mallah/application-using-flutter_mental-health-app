import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../resources/color-manager.dart';

class SignUpController extends GetxController {
  final String apiUrl = 'https://selene-m-h.up.railway.app:443/users/register';
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryController.dispose();
    birthController.dispose();
    super.dispose();
  }

  Future<void> postDataSignUp() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "first_name": fnameController.text,
          "last_name": lnameController.text,
          "email": emailController.text,
          "country": countryController.text,
          "gender": genderType,
          "birth": birthController.text,
          "password": passwordController.text,
          "type": "patient",
        }),
      );
      print(fnameController.text);
      print(lnameController.text);
      print(emailController.text);
      print(countryController.text);
      print( genderType);
      print( birthController.text);
      print(passwordController.text);
   


      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('response Body : $responseData');
      } else if (response.statusCode == 201) {
        final responseDataFail = jsonDecode(response.body);
        final res = responseDataFail['state'];

        // shure what message show
        print('Show dialog with message: $res');

        Get.defaultDialog(
          titlePadding: EdgeInsets.all(10),
          backgroundColor: ColorManager.elementBase,
          title: 'Error',
          content: Text(res),
          contentPadding: EdgeInsets.all(10),
          textConfirm: 'ok',
          confirmTextColor: Colors.white,
          buttonColor: ColorManager.buttonBase,
          onConfirm: () {
            print('Dialog confirmed');
            Get.back();
          },
        );
      } else {
        throw Exception('Failed, try again');
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(
        titlePadding: EdgeInsets.all(10),
        backgroundColor: ColorManager.elementBase,
        title: 'Error',
        content: Text(e.toString()),
        contentPadding: EdgeInsets.all(10),
        textConfirm: 'ok',
        confirmTextColor: Colors.white,
        buttonColor: ColorManager.buttonBase,
        onConfirm: () {
          print('dialog confirmed');
          Get.back();
        },
      );
    }
  }

// // for date
  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030),
        //to make color
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: ColorManager.buttonBase,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: ColorManager.buttonBase,
                ),
              ),
            ),
            child: child!,
          );
        });
    birthController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
    //print("Selected date: ${birthController.text}");
    update();
  }

  // Gender type
  //this default val
  String _genderType = "m";
  //save val
  String get genderType => _genderType;
  void setGenderType(String type) {
    _genderType = type;
    update();
  }
}
