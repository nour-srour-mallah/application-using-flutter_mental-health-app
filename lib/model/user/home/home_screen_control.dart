import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../resources/route.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class HomeControll extends GetxController {

  void SelectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Get.toNamed(Routes.getUpdateProfileRoute());
        break;
      case 1:
        Get.toNamed(Routes.getQuizRoute());
        break;
      case 2:
        final box = GetStorage();
        box.erase();
        Get.offAllNamed(Routes.getSignInRoute());
        break;
        case 3:
        Get.toNamed(Routes.getAboutRoute());
        break;
    }
  }
}

//
// //logout
class LogOutController extends GetxController {
  Future<void> postDataLogOut() async {
    final box = GetStorage();
    try {
      final response = await http.post(
        Uri.parse("https://selene-m-h.up.railway.app:443/users/logout"),
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
        final responseDataFail = jsonDecode(response.body);
        final res = responseDataFail['user'];
        print("res $res");
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
    }
  }
}
