import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class UploadPhoto {
  late String photo1;

  Future<Type> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photo'] = photo1;
    return UploadPhoto;
  }

  Future<dynamic> UploadImage(String bytes, String filename) async{
    final String uploadUrl = 'https://selene-m-h.up.railway.app:443/users/upload_photo/'
        '${GetStorage().read('email')}';
    try {
      final response = await http.post(
        Uri.parse(uploadUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "photo": "data:image/jpeg;base64,/9j/4AAQ$bytes"
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('response Body : $responseData');
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
    // var multipartFile = http.MultipartFile(
    //   'photo',
    //   http.ByteStream.fromBytes(bytes),
    //   bytes.length,
    //   filename: filename
    // );
    // request.files.add(multipartFile);
    // Response response = await request.send();
    //
    // if(response.statusCode == 201){
    //   var data = await response.stream.bytesToString();
    //
    //   return jsonDecode(data);
    // }
    // else{return null;}
  }
}