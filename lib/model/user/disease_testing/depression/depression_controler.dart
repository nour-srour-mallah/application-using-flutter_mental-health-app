import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../resources/route.dart';
import '../models/depression_model.dart';

class DepressionController extends GetxController {
  final String apiUrlQuestion = "https://selene-m-h.up.railway.app/ai/q_p_dep";
  final box = GetStorage();

  var questionsWithAnswer = <ModelDepression>[].obs;
  var questionIndex = 0.obs;
  var selectedAnswers =
      <String, dynamic>{}.obs; // Store indices or custom answers

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
        print("questions are: ${responseData['q']}");
        if (responseData['q'] != null) {
          questionsWithAnswer.value = List<ModelDepression>.from(
            responseData['q']
                .map((questionJson) => ModelDepression.fromJson(questionJson)),
          );
        } else {
          questionsWithAnswer.clear();
        }
      } else if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final exp = responseData['state'];
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(exp)],
            );
          },
        );
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

  void selectAnswer(int index, {String? customAnswer}) {
    final currentQuestion = questionsWithAnswer[questionIndex.value];
    if (customAnswer != null) {
      selectedAnswers[currentQuestion.title] = customAnswer;
    } else {
      selectedAnswers[currentQuestion.title] = index;
    }

    print("Selected answers: $selectedAnswers");

    if (questionIndex.value < questionsWithAnswer.length - 1) {
      questionIndex.value++;
    } else {
      postAnswers();
    }
  }

  final String apiUrlAnswer = "https://selene-m-h.up.railway.app/ai/p_dep";
  Future<void> postAnswers() async {
    try {
      // Convert all string values to integers if possible
      final convertedAnswers = selectedAnswers.map((key, value) {
        if (value is String) {
          // Attempt to parse value to integer
          final intValue = int.tryParse(value);
          return MapEntry(key, intValue ?? value);
        }
        return MapEntry(key, value);
      });

      final data = <String, dynamic>{
        'email': box.read('email'),
        'token': box.read('token'),
        ...convertedAnswers,
      };

      final response = await http.post(
        Uri.parse(apiUrlAnswer),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      print("JSON Data Sent:");
      print(jsonEncode(data));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final result = responseData['Iris_P_Dep'];
        box.write('Deppresion', result);
        print("Result is $result");
        Get.offNamed(Routes.getShowResultDepRoute());
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

  double calculateAnsweredPercentage() {
    final totalQuestions = questionsWithAnswer.length;
    final answeredQuestions = selectedAnswers.length;
    return (answeredQuestions / totalQuestions) * 100;
  }
}
