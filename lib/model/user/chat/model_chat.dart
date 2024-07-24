import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final ChatController chatController = Get.put(ChatController());
  static void logout() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ChatController.chat.clear();
      ChatController.chat1.clear();
    });
  }
}

class model_chat {
  String text;
  String sender_name;
  DateTime? timestamp;

  model_chat(this.text, this.sender_name, this.timestamp);
}
class ChatController extends GetxController {
//message
  static RxList<model_chat> chat = <model_chat>[].obs;
  static RxList<model_chat> chat1 = <model_chat>[].obs;
}

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class AuthController extends GetxController {
//   final ChatController chatController = Get.put(ChatController());
//   static void logout() {
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//    ChatController.chat.clear();
//    ChatController.chat1.clear();
// });
//   }
// }
//
// class model_chat {
//   String text;
//   String sender_name;
//   DateTime? timestamp;
//
//   model_chat(this.text, this.sender_name, this.timestamp);
// }
// class ChatController extends GetxController {
// //message
//   static RxList<model_chat> chat = <model_chat>[].obs;
//   static RxList<model_chat> chat1 = <model_chat>[].obs;
// }
