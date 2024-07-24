import 'dart:convert';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as https;

class RatingController extends GetxController {
  int currentRating = 0;
  final box = GetStorage();
  double result = 0;
  @override
  void onInit() {
    super.onInit();
    currentRating = box.read('rating') ?? 0;
  }

  void updateAndStoreRating(int rating) {
    currentRating = rating;
    box.write('rating', rating);
    update();
  }

  Widget buildRatingStar(int index) {
    if (index < currentRating) {
      return const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 40,
      );
    } else {
      return const Icon(
        Icons.star,
        color: Colors.white,
        size: 40,
      );
    }
  }

  // for post rate
  Future<void> postRate() async {
    try {
      final response = await https.post(
        Uri.parse(apiEndpoints.baseUrl + apiEndpoints.authEndpoints.rate),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': GetStorage().read('email'), // Read email directly
          'token': GetStorage().read('token'),
          'doctor': GetStorage().read('currentDoc'),
          'rate': currentRating,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        result = double.parse(responseData['new_rate'].toString());
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Error'),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(e.toString())],
          );
        },
      );
    }
  }
}
