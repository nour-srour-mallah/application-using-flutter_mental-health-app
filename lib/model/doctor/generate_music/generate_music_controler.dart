
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as https;
import '../../../services/endpoints_api.dart';

class GenerateMusicController extends GetxController {
  TextEditingController descriptionController = TextEditingController();

  RxList<String> emailPatients = <String>[].obs;
  RxString selectedPatient = RxString('');
  RxString selectedItem = RxString('');

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getpatients();
  }

  final box = GetStorage();

  Future<void> postMusic() async {
    try {
      final response = await https.post(
        Uri.parse("https://selene-m-h.up.railway.app/sounds/music/gen"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "doctor": box.read('email'),
          "patient": selectedPatient.value,
          "desc": descriptionController.text,
          "type": selectedItem.value,
        }),
      ).timeout(
        const Duration(seconds: 50),
        onTimeout: () {
          return https.Response('Error', 408);
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("the select item is : $selectedItem");
      print("the select patient is : $selectedPatient");

      if (response.statusCode == 200) {
        print("Successful POST request");
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print(e);
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

  Future<void> getpatients() async {
    try {
      final response = await https.post(
        Uri.parse(apiEndpoints.baseUrl +
            apiEndpoints.authEndpointsDoctor.showPatient),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': box.read('email'),
          'token': box.read('token'),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        var patientsInfo = responseData['info'];

        if (patientsInfo != null) {
          List<String> emails =
          List<String>.from(patientsInfo.map((info) => info['email']));
          print("Patient connect: $emails");
          emailPatients.value = emails;
          box.write('emailPatients', emails);
          print("to check get patient: ${box.read('emailPatients')}");
        } else {
          throw Exception('no patient');
        }
      } else {
        throw Exception('Failed to fetch');
      }
    } catch (e) {
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

  void upDateSelectedPatient(String value) {
    selectedPatient.value = value;
  }

  void upDateSelectedItem(String value) {
    selectedItem.value = value;
  }
}
