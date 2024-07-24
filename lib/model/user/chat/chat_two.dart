// import 'package:flutter/material.dart';
// import '../../../resources/color-manager.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';
//
// import 'model_chat.dart';
//
// class ChatTwo extends StatefulWidget {
//   ChatTwo({Key? key});
//
//   @override
//   State<ChatTwo> createState() => _ChatTwoState();
// }
//
// class _ChatTwoState extends State<ChatTwo> {
//   //message
//
//   TextEditingController text = TextEditingController();
//   //id user
//   String myName = "chat1";
//   @override
//   Widget build(BuildContext context) {
//     double widthScreen = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: ColorManager.primaryPanicAttack,
//         appBar: AppBar(
//           backgroundColor: ColorManager.appBarPanicAttack,
//           elevation: 2,
//           title: const Text(
//             "chat 2",
//             style: TextStyle(
//               fontSize: 20,
//               fontFamily: "Shrikhand",
//             ),
//           ),
//         ),
//         body: Container(
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemBuilder: (_, index) => BubbleSpecialThree(
//                     //to make left or right message
//                     isSender: chat[index].sender_name == myName ? true : false,
//                     text: chat[index].text,
//                     color: chat[index].sender_name == myName
//                         ? ColorManager.elementPanicAttack
//                         : ColorManager.sectioHeaderPanicAttack,
//                     tail: true,
//                     textStyle: TextStyle(
//                       color: ColorManager.secondPanicAttack,
//                       fontSize: 16,
//                     ),
//                   ),
//                   itemCount: chat.length,
//                   padding: EdgeInsets.all(10),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: text,
//                             cursorColor: ColorManager.secondPanicAttack,
//                             style: TextStyle(
//                               color: ColorManager.secondPanicAttack,
//                             ),
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: ColorManager.secondPanicAttack,
//                                 ),
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: ColorManager.secondPanicAttack,
//                                 ),
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: ColorManager.secondPanicAttack,
//                                 ),
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               filled: true,
//                               fillColor: ColorManager.sectioHeaderPanicAttack,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: widthScreen * 0.02,
//                         ),
//                         FloatingActionButton(
//                           backgroundColor: ColorManager.secondPanicAttack,
//                           onPressed: () {
//                             setState(() {
//                               chat.add(model_chat(text.text, myName));
//                               text.text = "";
//                             });
//                           },
//                           child: Icon(
//                             Icons.send,
//                             color: ColorManager.appBarPanicAttack,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
