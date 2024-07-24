import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../../../../services/endpoints_api.dart';
import 'model_get_doc_list.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class GetAllDocsController extends GetxController {
  final String apiUrl = apiEndpoints.baseUrl + "/users/get_doctor_list";
  String email = '';
  String firstName = '';
  String lastName = '';
  String rate = '';
  String address ='';
  String specialization ='';

  RxList<docList> docs = <docList>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getListDocs();
  }



  Future<void> getListDocs() async {
    try {
      final response = await http.post(
        Uri.parse(apiEndpoints.baseUrl + "/users/get_doctor_list"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "user": box.read('email'),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        docs.assignAll(
          List.generate(
            responseData.length,
                (index) => docList(
              email: responseData[index]['email'],
              firstName: responseData[index]['firstName'],
              lastName: responseData[index]['lastName'],
              rate: responseData[index]['rate'],
              address: responseData[index]['clinic_address'],
              specialization: responseData[index]['specialization'],
              doctors: null,
            ),
          ),
        );
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        throw Exception('Failed, try again');
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
}
