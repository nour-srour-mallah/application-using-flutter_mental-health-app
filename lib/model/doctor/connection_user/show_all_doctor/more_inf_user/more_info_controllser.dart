
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MoreInfoController extends GetxController {
  final String apiUrl = "https://selene-m-h.up.railway.app/ai/patient_all_info";
  final box = GetStorage();

@override
  void onInit() {
    // TODO: implement onInit
  getInfo();
    super.onInit();
  }
  final data = {}.obs;

  Future<void> getInfo() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': GetStorage().read('email'),
          'token': GetStorage().read('token'),
          "patient": GetStorage().read("currentDoc")
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        responseData['arr'].forEach((key, value) {
          if (value != null) {
            box.write(key, value);
            data[key] = value;
          }
        });
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
        },
      );
    }
  }
}
