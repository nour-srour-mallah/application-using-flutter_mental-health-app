import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';

import '../../../main.dart';
import 'package:flutter/material.dart';
import '../../../resources/color-manager.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:pusher_websockets_client/dart_pusher_channels.dart';
import 'package:http/http.dart' as http;

import '../../../resources/route.dart';
import 'model_chat.dart';
import 'network_user_model.dart';

class ChatOne extends StatefulWidget {
  const ChatOne({super.key});

  @override
  State<ChatOne> createState() => _ChatOneState();
}

class _ChatOneState extends State<ChatOne> {
  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.put(AuthController());
  final box = GetStorage();
  String emailDoc = GetStorage().read("currentDoc").toString();
  Future<List<Network1>> fetchDocsChats() async {
    http.Response response = await http.get(Uri.parse(apiEndpoints.baseUrl + apiEndpoints.authEndpoints.network),);
    var responseJson = json.decode(response.body);
    return (responseJson['doctors']).map((m) => Network1.fromJson(m)).toList();
  }

  //message
  TextEditingController text = TextEditingController();
  //id user
  String myEmail = GetStorage().read("email");
  @override
  void initState() {
    send("");
    super.initState();
    setupPusher();
  }
  Future<void> send(String msg) async {
    AuthController.logout();
    final url = "https://selene-m-h.up.railway.app/chat/";
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode({
        "email": GetStorage().read('email'), // sender's email
        "token": GetStorage().read('token'), // sender's token
        "recive": emailDoc, // reciever's email
        "msg": msg, // Message text

      }
      ),

    );
    print(emailDoc);
    if (response.statusCode == 200) {
      final responseBody = convert.jsonDecode(response.body);
      final messages = responseBody["ms"];


      for (final message in messages) {
        final sender = message["sender"];
        final messageText = message["message"];
        final timestamp = message["timestamp"];
        model_chat model = model_chat(messageText,sender,DateTime.now());

        ChatController.chat1.add(model);

        print("Received message from $sender: $messageText ($timestamp)");
      }


    } else {
      print("Error: ${response.statusCode}");
    }
  }

  void setupPusher() async {
    PusherChannelsPackageLogger.enableLogs();
    const testOptions = PusherChannelsOptions.fromCluster(
      scheme: 'ws',
      cluster: 'ap2',
      key: '5571a7e3223bf9795d51',
      port: 80,
    );
    final client = PusherChannelsClient.websocket(
      options: testOptions,
      connectionErrorHandler: (exception, trace, refresh) async {
        refresh();
      },
    );
    PublicChannel myPublicChannel = client.publicChannel(
      myEmail,
    );
    StreamSubscription<ChannelReadEvent> somePublicChannelEventSubs =
    myPublicChannel.bind('event').listen((event) {
      setState(() {
        // ChatController.chat1.add(modelrecieved);
        send("");
      });
      // model_chat modelrecieved = model_chat(event.data["message"], emailDoc, DateTime.now());
    });
    final allEventSubs = <StreamSubscription?>[
      somePublicChannelEventSubs,
    ];
    final allChannels = <Channel>[
      myPublicChannel,
    ];
    final StreamSubscription connectionSubs =
    client.onConnectionEstablished.listen((_) {
      for (final channel in allChannels) {
        channel.subscribeIfNotUnsubscribed();
      }
    });
    unawaited(client.connect());
  }
  @override
  Widget build(BuildContext context) {

    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        appBar: AppBar(
            leading: IconButton(onPressed: () {
              if (GetStorage().read('type') == "patient") {
                Get.toNamed(Routes.getHomeRoute());
              } else if (GetStorage().read('type') ==
                  "doctor") {
                Get.offNamed(Routes.getHomeDoctorRoute());
              } else {
                Get.snackbar(
                  "Error",
                  "Unexpected user type.",
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                  backgroundColor:
                  Color.fromARGB(255, 190, 83, 83),
                );
              }
            }, icon: Icon(Icons.arrow_back),

            ),
            backgroundColor: ColorManager.appBarPanicAttack,
            elevation: 2,
            title: Text(
              GetStorage().read("DocName"),
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Shrikhand",
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  if (GetStorage().read('type') == "patient") {
                    Get.toNamed(Routes.getInfoDoctorRoute());
                  } else if (GetStorage().read('type') ==
                      "doctor") {
                    Get.toNamed(Routes.getInfoUserRoute());
                  } else {
                    Get.snackbar(
                      "Error",
                      "Unexpected user type.",
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      backgroundColor:
                      Color.fromARGB(255, 190, 83, 83),
                    );
                  }
                },
              ),
            ]
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                      ()=>ListView.builder(
                    padding: const EdgeInsets.all(10),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ChatController.chat.length + ChatController.chat1.length,
                    itemBuilder: (_, index) {

                      // Build a widget for each message
                      return BubbleSpecialThree(
                        isSender: ChatController.chat1[index].sender_name == GetStorage().read('email') ? true: false,
                        text: ChatController.chat1[index].text,
                        color: ChatController.chat1[index].sender_name == GetStorage().read('email') ? ColorManager.elementPanicAttack : ColorManager.sectioHeaderPanicAttack,
                        tail: ChatController.chat1[index].sender_name == GetStorage().read('email'),
                        textStyle: TextStyle(
                          color: ColorManager.secondPanicAttack,
                          fontSize: 16,
                        ),
                      );
                    },
                  )
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: text,
                          cursorColor: ColorManager.secondPanicAttack,
                          style: TextStyle(
                            color: ColorManager.secondPanicAttack,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.secondPanicAttack,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.secondPanicAttack,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.secondPanicAttack,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            filled: true,
                            fillColor: ColorManager.sectioHeaderPanicAttack,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: widthScreen * 0.02,
                      ),
                      FloatingActionButton(
                        backgroundColor: ColorManager.secondPanicAttack,
                        onPressed: () {
                          setState(() {
                            send(text.text);
                            text.text = "";
                          });
                        },
                        child: Icon(
                          Icons.send,
                          color: ColorManager.appBarPanicAttack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:async';
// import 'dart:convert' as convert;
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get_storage/get_storage.dart';
//
// import '../../../main.dart';
// import 'package:flutter/material.dart';
// import '../../../resources/color-manager.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';
// import 'package:pusher_websockets_client/dart_pusher_channels.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../resources/route.dart';
// import 'model_chat.dart';
// import 'network_user_model.dart';
//
// class ChatOne extends StatefulWidget {
//   const ChatOne({super.key});
//
//   @override
//   State<ChatOne> createState() => _ChatOneState();
// }
//
// class _ChatOneState extends State<ChatOne> {
//   final ChatController chatController = Get.put(ChatController());
//   final AuthController authController = Get.put(AuthController());
//   final box = GetStorage();
//   String emailDoc = GetStorage().read("currentDoc").toString();
//   Future<List<Network1>> fetchDocsChats() async {
//     http.Response response = await http.get(Uri.parse(apiEndpoints.baseUrl + apiEndpoints.authEndpoints.network),);
//     var responseJson = json.decode(response.body);
//     return (responseJson['doctors']).map((m) => Network1.fromJson(m)).toList();
//   }
//
//   //message
//   TextEditingController text = TextEditingController();
//   //id user
//   String myEmail = GetStorage().read("email");
//   @override
//   void initState() {
//     send("");
//     super.initState();
//     _setupPusher();
//   }
//   Future<void> send(String msg) async {
//     AuthController.logout();
//   final url = "https://selene-m-h.up.railway.app/chat/";
//   final response = await http.post(
//     Uri.parse(url),
//     headers: {"Content-Type": "application/json"},
//     body: convert.jsonEncode({
//       "email": GetStorage().read('email'), // sender's email
//       "token": GetStorage().read('token'), // sender's token
//       "recive": emailDoc, // reciever's email
//       "msg": msg, // Message text
//     }),
//   );
//
//   if (response.statusCode == 200) {
//     final responseBody = convert.jsonDecode(response.body);
//     final messages = responseBody["ms"]; // Assuming messages are in "ms" field
//
//     // Create a list to hold the new messages
//     List<model_chat> newMessages = [];
//
//     for (final message in messages) {
//       final sender = message["sender"];
//       final messageText = message["message"];
//       final timestamp = message["timestamp"];
//       model_chat model = model_chat(messageText,sender,DateTime.now());
//
//       // Add the new message to the list
//       newMessages.add(model);
// // Add all new messages to the chat at once
//     if(message["sender"] == GetStorage().read('email')){
//       ChatController.chat.addAll(newMessages);
//     }else {
//       ChatController.chat1.addAll(newMessages);
//     }
//       print("Received message from $sender: $messageText ($timestamp)");
//     }
//
//
//   } else {
//     print("Error: ${response.statusCode}");
//   }
// }
//
//   void _setupPusher() async {
//     PusherChannelsPackageLogger.enableLogs();
//     const testOptions = PusherChannelsOptions.fromCluster(
//       scheme: 'ws',
//       cluster: 'ap2',
//       key: '5571a7e3223bf9795d51',
//       port: 80,
//     );
//     final client = PusherChannelsClient.websocket(
//       options: testOptions,
//       connectionErrorHandler: (exception, trace, refresh) async {
//         refresh();
//       },
//     );
//     PublicChannel myPublicChannel = client.publicChannel(
//       myEmail,
//     );
//     StreamSubscription<ChannelReadEvent> somePublicChannelEventSubs =
//     myPublicChannel.bind('event').listen((event) {
//       model_chat modelrecieved = model_chat(event.data["message"], emailDoc, DateTime.now());
//       ChatController.chat1.add(modelrecieved);
//       setState(() {
//         // _eventData!.text = event.data;
//         // _eventData!.sender_name = "m.almouhtaseb@gmail.com";
//         // print(event.data);
//         ChatController.chat1.add(modelrecieved);
//
//       });
//     });
//     final allEventSubs = <StreamSubscription?>[
//       somePublicChannelEventSubs,
//     ];
//     final allChannels = <Channel>[
//       myPublicChannel,
//     ];
//     final StreamSubscription connectionSubs =
//     client.onConnectionEstablished.listen((_) {
//       for (final channel in allChannels) {
//         channel.subscribeIfNotUnsubscribed();
//       }
//     });
//     unawaited(client.connect());
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     double heightScreen = MediaQuery.of(context).size.height;
//
//
//
//
//     double widthScreen = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: ColorManager.primaryPanicAttack,
//         appBar: AppBar(
//           leading: IconButton(onPressed: () {
//             if (GetStorage().read('type') == "patient") {
//               Get.toNamed(Routes.getHomeRoute());
//             } else if (GetStorage().read('type') ==
//                 "doctor") {
//               Get.offNamed(Routes.getHomeDoctorRoute());
//             } else {
//               Get.snackbar(
//                 "Error",
//                 "Unexpected user type.",
//                 snackPosition: SnackPosition.BOTTOM,
//                 colorText: Colors.white,
//                 backgroundColor:
//                 Color.fromARGB(255, 190, 83, 83),
//               );
//             }
//           }, icon: Icon(Icons.arrow_back),
//
//           ),
//             backgroundColor: ColorManager.appBarPanicAttack,
//             elevation: 2,
//             title: Text(
//               GetStorage().read("DocName"),
//               style: TextStyle(
//                 fontSize: 20,
//                 fontFamily: "Shrikhand",
//               ),
//             ),
//             actions: <Widget>[
//               IconButton(
//                 icon: const Icon(Icons.more_vert),
//                 onPressed: () {
//                   if (GetStorage().read('type') == "patient") {
//                     Get.toNamed(Routes.getInfoDoctorRoute());
//                   } else if (GetStorage().read('type') ==
//                       "doctor") {
//                     Get.toNamed(Routes.getInfoUserRoute());
//                   } else {
//                     Get.snackbar(
//                       "Error",
//                       "Unexpected user type.",
//                       snackPosition: SnackPosition.BOTTOM,
//                       colorText: Colors.white,
//                       backgroundColor:
//                       Color.fromARGB(255, 190, 83, 83),
//                     );
//                   }
//                 },
//               ),
//             ]
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: Obx(
//                       ()=>ListView.builder(
//                     padding: const EdgeInsets.all(10),
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: ChatController.chat.length + ChatController.chat1.length,
//                     itemBuilder: (_, index) {
//                       RxList<model_chat> combinedChat = RxList.generate(ChatController.chat.length, (i) => model_chat(ChatController.chat[i].text, myEmail,ChatController.chat[i].timestamp!))
//                         ..addAll(List.generate(ChatController.chat1.length, (i) => model_chat(ChatController.chat1[i].text, emailDoc,ChatController.chat1[i].timestamp!)));
//                       combinedChat.sort((a, b) {
//                         // If both timestamps are non-null, compare them directly
//                         if (a.timestamp != null && b.timestamp != null) {
//                           return a.timestamp!.compareTo(b.timestamp!);
//                         }
//                         // If one timestamp is null, sort it to the end
//                         if (a.timestamp == null) return 1;
//                         if (b.timestamp == null) return -1;
//                         // If both timestamps are null, consider them equal
//                         return 0;
//                       });
//                       // Build a widget for each message
//                       return BubbleSpecialThree(
//                         isSender: combinedChat[index].sender_name == GetStorage().read('email') ? true: false,
//                         text: combinedChat[index].text,
//                         color: combinedChat[index].sender_name == GetStorage().read('email') ? ColorManager.elementPanicAttack : ColorManager.sectioHeaderPanicAttack,
//                         tail: combinedChat[index].sender_name == GetStorage().read('email'),
//                         textStyle: TextStyle(
//                           color: ColorManager.secondPanicAttack,
//                           fontSize: 16,
//                         ),
//                       );
//                     },
//                   )
//               ),
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: text,
//                           cursorColor: ColorManager.secondPanicAttack,
//                           style: TextStyle(
//                             color: ColorManager.secondPanicAttack,
//                           ),
//                           decoration: InputDecoration(
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: ColorManager.secondPanicAttack,
//                               ),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: ColorManager.secondPanicAttack,
//                               ),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: ColorManager.secondPanicAttack,
//                               ),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             filled: true,
//                             fillColor: ColorManager.sectioHeaderPanicAttack,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: widthScreen * 0.02,
//                       ),
//                       FloatingActionButton(
//                         backgroundColor: ColorManager.secondPanicAttack,
//                         onPressed: () {
//                           setState(() {
//                             //sent message input
//                             send(text.text);
//                             text.text = "";
//                           });
//                         },
//                         child: Icon(
//                           Icons.send,
//                           color: ColorManager.appBarPanicAttack,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
