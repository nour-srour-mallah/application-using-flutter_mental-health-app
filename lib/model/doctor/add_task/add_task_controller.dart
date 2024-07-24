import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as https;
import '../../../services/endpoints_api.dart';

class AddTaskController extends GetxController {
  TextEditingController aimController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController goalController2 = TextEditingController();
  RxBool showTask2 = false.obs;


  //to store email
  RxList<String> emailPatients = <String>[].obs;

  @override
  void onClose() {
    aimController.dispose();
    goalController.dispose();
    goalController2.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getpatients();
  }

  final box = GetStorage();

  Future<void> postDataGoal() async {
    try {
      final response = await https.post(
        Uri.parse(
            apiEndpoints.baseUrl + apiEndpoints.authEndpointsDoctor.addToDO),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': box.read('email'),
          'token': box.read('token'),
          'patients': [selectedItem.value],
          'aim': aimController.text,
          'goals': [goalController.text, goalController2.text]
        }),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print("Successful POST request");
      } else {
        throw Exception('Failed to post data');
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
          });
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
          });
    }
  }

//to make dropdownbutton
  var selectedItem = "".obs;
  void upDateSelectedItem(String value) {
    selectedItem.value = value;
  }
}
