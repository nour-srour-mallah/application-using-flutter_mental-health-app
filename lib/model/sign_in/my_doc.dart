import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowDocController extends GetxController {
  final String apiUrl = 'https://selene-m-h.up.railway.app:443/chat/network';
  RxList<Map<String, dynamic>> docList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;

  Future<void> getDoc() async {
    final box = GetStorage();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
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
        final networkList = responseData['network'];

        if (networkList != null && networkList is List) {
          List<Map<String, dynamic>> tempList = [];
          for (var data in networkList) {
            Map<String, dynamic> docData = {
              'first_name': data['first_name'],
              'last_name': data['last_name'],
              'email': data['email'],
              'specialization': data['specialization'],
              'clinic_address': data['clinic_address'],
              'rate': data['rate']
            };
            tempList.add(docData);
          }
          docList.assignAll(tempList);
          isLoading.value = false;
        } else {
          hasError.value = true;
          throw Exception('Invalid network data');
        }
      } else {
        hasError.value = true;
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
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