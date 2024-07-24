import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../resources/route.dart';
import '../models/depression_bipolar_model.dart';

class DepressionBipolarController extends GetxController {
  final String apiUrlQuestion = "https://selene-m-h.up.railway.app/ai/q_dep_bi";
  final box = GetStorage();

  var questionsWithAnswer = <ModelDepressionBipolar>[].obs;
  var questionIndex = 0.obs;
  var selectedAnswers = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getQuestion();
  }

  Future<void> getQuestion() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlQuestion),
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
        print("questions is: ${responseData['q']}");
        if (responseData['q'] != null) {
          questionsWithAnswer.value = List<ModelDepressionBipolar>.from(
            responseData['q'].map((questionJson) =>
                ModelDepressionBipolar.fromJson(questionJson)),
          );
        } else {
          questionsWithAnswer.clear();
        }
      } else {
        throw Exception('failed, try again');
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

  //to move between question and post when finish and send answer

  void selectAnswer(int index) {
    final currentQuestion = questionsWithAnswer[questionIndex.value];
    selectedAnswers[currentQuestion.title] = currentQuestion.answers[index];

    print("Selected answers: $selectedAnswers");

    if (questionIndex.value < questionsWithAnswer.length - 1) {
      questionIndex.value++;
    } else {
      postAnswers();
    }
  }

//to post answer
  final String apiUrlAnswer = "https://selene-m-h.up.railway.app/ai/dep_bi";
  Future<void> postAnswers() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlAnswer),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': box.read('email'),
          'token': box.read('token'),
          ...selectedAnswers,
        }),
      );
      print("JSON Data Sent:");
      print(jsonEncode(<String, dynamic>{
        'email': box.read('email'),
        'token': box.read('token'),
        ...selectedAnswers,
      }));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final res = responseData['Iris_Dep_Bi'];
        box.write('depressionBipolar', res);
        print("res dep is $res");
        print("shure getstorage ${box.read('depressionBipolar')}");
        Get.offNamed(Routes.getShowResultDepressionRoute());
      } else {
        throw Exception('failed, try again');
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

// Calculate the percentage of answered questions to make time line
  double calculateAnsweredPercentage() {
    final totalQuestions = questionsWithAnswer.length;
    final answeredQuestions = selectedAnswers.length;
    return (answeredQuestions / totalQuestions) * 100;
  }
}
