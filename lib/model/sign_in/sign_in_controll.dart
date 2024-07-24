import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../resources/color-manager.dart';

class SignInController extends GetxController {
  final String apiUrl = "https://selene-m-h.up.railway.app:443/users/login";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final box = GetStorage();
  @override
  void onInit() {
    emailController.text = '';
    passwordController.text = '';
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> postDataSignIn() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": emailController.text,
          "password": passwordController.text
        }),
      );
      print("email is :${emailController.text}");
      print("password is :${passwordController.text}");
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        'first_name: ${responseData['state']['first_name']}last_name: ${responseData['state']['last_name']}email: ${responseData['state']['email']}country: ${responseData['state']['country']}gender: ${responseData['state']['gender']}birth: ${responseData['state']['birth']}photo: ${responseData['state']['photo']}language: ${responseData['state']['language']}password: ${responseData['state']['password']}token: ${responseData['state']['token']}type: ${responseData['state']['type']}private_key:${responseData['state']['private_key']}';

        final box = GetStorage();
        box.write('token', responseData['state']['token']);
        box.write('email', responseData['state']['email']);
        box.write('password', responseData['state']['password']);
        box.write('type', responseData['state']['type']);
        box.write('first_name', responseData['state']['first_name']);
        box.write('last_name', responseData['state']['last_name']);
        box.write('country', responseData['state']['country']);
        box.write('password', responseData['state']['password']);
        box.write('private_key', responseData['state']['private_key']);

        // make suse storage
        print("type is : ${box.read('type')}");
        return true;
      } else if (response.statusCode == 201) {
        final responseDataFail = jsonDecode(response.body);
        final res = responseDataFail['state'];

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
        return false;
      } else {
        throw Exception('Failed, try again');
      }
    } catch (e) {
      print("Exception: $e");
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
      return false;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////////////
//////api to know if have ilnesses or not

  Future<void> postKnowIllnesses() async {
    try {
      final response = await http.post(
        Uri.parse("https://selene-m-h.up.railway.app/ai/id_do_test"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': box.read('email'),
          'token': box.read('token'),
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String haveIllnessString = responseData['res'] ? "true" : "false";
        if(haveIllnessString == true) {
          box.write('have_illness', haveIllnessString);
          box.write("currentDoc", responseData['email']);
          box.write("DocName",
              "${responseData['first_name']} ${responseData['last_name']}");
          box.write("DocSpecial", responseData['specialization']);
          box.write("DocAddress", responseData['clinic_address']);
          box.write("DocRate", responseData['rate']);
          print("have_illness is : ${box.read('have_illness')}");
        }
      } else {
        throw Exception('Failed to know illness, try again');
      }
    } catch (e) {
      print("Exception: $e");
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }

}
