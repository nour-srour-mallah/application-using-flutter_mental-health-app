// import 'dart:convert';

// import 'package:get_storage/get_storage.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:http/http.dart' as http;

// class ShowUserController extends GetxController {
//   @override
//   void onInit() {
//     getUser();
//     super.onInit();
//   }

//   final String apiUrl = 'https://selene-m-h.up.railway.app:443/chat/network';

//   final box = GetStorage();
//   Future<void> getUser() async {
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'email': box.read('email'),
//           'token': box.read('token'),
//         }),
//       );

//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         ////////////////////////////////////////////////////////////////////////////////

//         'first_name: ${responseData['network']['first_name']}last_name: ${responseData['network']['last_name']}email: ${responseData['network']['email']}birth: ${responseData['network']['birth']}gender: ${responseData['network']['gender']}';

//         final box = GetStorage();

//         box.write('first_name', responseData['network']['first_name']);
//         box.write('last_name', responseData['network']['last_name']);
//         box.write('email', responseData['network']['email']);
//         print("first_name is : ${box.read('first_name')}");
//       } else {
//         throw Exception('Failed to post data');
//       }
//     } catch (e) {
//       Get.back();
//       showDialog(
//           context: Get.context!,
//           builder: (context) {
//             return SimpleDialog(
//               title: Text('Error'),
//               contentPadding: EdgeInsets.all(20),
//               children: [Text(e.toString())],
//             );
//           });
//     }
//   }
// }
//*****************************************************************
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// class ShowUserController extends GetxController {
//   final String apiUrl = 'https://selene-m-h.up.railway.app:443/chat/network';

//   @override
//   void onInit() {
//     getUser();
//     super.onInit();
//   }

//   Future<void> getUser() async {
//     final box = GetStorage();
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'email': box.read('email'),
//           'token': box.read('token'),
//         }),
//       );

//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         final networkList = responseData['network'];

//         if (networkList != null && networkList is List) {
//           List<Map<String, dynamic>> userList = [];
//           for (var data in networkList) {
//             Map<String, dynamic> userData = {
//               'first_name': data['first_name'],
//               'last_name': data['last_name'],
//               'email': data['email'],
//               'birth': data['birth'],
//               'gender': data['gender'],
//             };
//             userList.add(userData);
//           }
//           box.write('userList', userList);
//           print('User list stored: $userList');
//         } else {
//           throw Exception('Invalid network data');
//         }
//       } else {
//         throw Exception('Failed to fetch data');
//       }
//     } catch (e) {
//       Get.back();
//       showDialog(
//         context: Get.context!,
//         builder: (context) {
//           return SimpleDialog(
//             title: Text('Error'),
//             contentPadding: EdgeInsets.all(20),
//             children: [Text(e.toString())],
//           );
//         },
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowUserController extends GetxController {
  final String apiUrl = 'https://selene-m-h.up.railway.app:443/chat/network';
  RxList<Map<String, dynamic>> userList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
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
            Map<String, dynamic> userData = {
              'first_name': data['first_name'],
              'last_name': data['last_name'],
              'email': data['email'],
              'birth': data['birth'],
              'gender': data['gender'],
            };
            tempList.add(userData);
          }
          userList.assignAll(tempList);
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
