// import 'package:flutter/material.dart';
//
// import '../../../resources/color-manager.dart';
// import '../../../resources/svg.dart';
// import '../../../widgets/category_slider.dart';
//
// class Categorycard {
//   static List<String> images = [cat1, cat2, cat3, cat5];
//   static const List<String> illness = [
//     "Depression",
//     "bipolar disorder",
//     "Panic attack",
//     "Anxiety"
//   ];
//   static const List<String> catigo = [
//     'SVG/cat1.png',
//     'SVG/pibolar.png',
//     'SVG/man.png',
//     'SVG/blue.png'
//   ];
// }
//
// class Categories extends StatelessWidget {
//   const Categories({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double heightScreen = MediaQuery.of(context).size.height;
//     double widthScreen = MediaQuery.of(context).size.width;
//
//     //int selected = 0;
//     return Scaffold(
//       backgroundColor: ColorManager.primaryPanicAttack,
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 130, 130, 167),
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30))),
//             height: heightScreen / 6,
//             width: widthScreen,
//             child: const Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 60),
//                 child: Text("Select the illnesses that you may have",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontFamily: "Pacifico",
//                     )),
//               ),
//             ),
//           ),
//           CategorySlider(
//             heightScreen: heightScreen,
//           )
//         ],
//       ),
//     );
//   }
// }
