// import 'package:flutter/material.dart';

// import '../resources/color-manager.dart';

// class ItemMusicStyle extends StatelessWidget {
//   const ItemMusicStyle({
//     super.key,
//     required this.widthScreen,
//     required this.heightScreen,
//   });

//   final double widthScreen;
//   final double heightScreen;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         //////////////neeed to add nav
//       },
//       child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: ColorManager.elementPanicAttack,
//             image: DecorationImage(
//               image: AssetImage("assets/images/quran.jfif"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           width: widthScreen * 0.5,
//           margin: EdgeInsets.symmetric(horizontal: 8.0),
//           child: Stack(
//             children: [
//               SizedBox(
//                   height: heightScreen * 0.18,
//                   width: widthScreen * 0.45,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 100, left: 28),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         color: Color.fromARGB(201, 255, 255, 255),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "classic",
//                           style: TextStyle(fontSize: widthScreen * 0.04),
//                         ),
//                       ),
//                     ),
//                   ))
//             ],
//           )),
//     );
//   }
// }
