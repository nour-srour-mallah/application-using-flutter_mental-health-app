import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as https;
import '../../../services/endpoints_api.dart';

class ToDoController extends GetxController {
  RxString aim = ''.obs;
  RxMap<String, List<String>> goalsMap = <String, List<String>>{}.obs;
  RxBool loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    try {
      final response = await https.post(
        Uri.parse(
            apiEndpoints.baseUrl + apiEndpoints.authEndpointsUser.toDoUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': GetStorage().read('email'),
          'token': GetStorage().read('token'),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final state = responseData['state'] as Map<String, dynamic>;

        List<String> aims = [];
        Map<String, List<String>> goals = {};

        state.forEach((key, value) {
          aims.add(key);
          goals[key] =
              (value as List).map<String>((item) => item.keys.first).toList();
        });

        aim.value = aims.join(", ");
        goalsMap.value = goals;

        GetStorage().write('aim', aim.value);
        GetStorage().write('goals', goals);

        print('Response status : ${response.statusCode}');
        print('Response body: ${response.body}');

        print("aim is : ${GetStorage().read('aim')}");
        print("goal is : ${GetStorage().read('goals')}");
      } else {
        throw Exception('Failed to post email and get data');
      }
    } catch (e) {
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
    } finally {
      loading.value = false;
    }
  }

  Future<void> deleteGoal(String aim, String goal) async {
    try {
      final response = await https.post(
        Uri.parse("https://selene-m-h.up.railway.app/to-do-list/done-goal"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': GetStorage().read('email'),
          'token': GetStorage().read('token'),
          'aim': aim,
          'goal': goal,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['state'] == 'success') {
          goalsMap[aim]!.remove(goal);
          goalsMap.refresh();
        }
      } else {
        throw Exception('Failed to delete goal');
      }
    } catch (e) {
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
