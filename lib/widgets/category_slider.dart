// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../resources/font_manager.dart' as font;
// import '../model/user/categories/categories_screen.dart';
// import '../resources/route.dart';
//
// class CategorySlider extends StatelessWidget {
//   const CategorySlider({
//     super.key,
//     required this.heightScreen,
//   });
//
//   final double heightScreen;
//
//   @override
//   Widget build(BuildContext context) {
//     double widthScreen = MediaQuery.of(context).size.width;
//     return CarouselSlider.builder(
//       carouselController: CarouselController(),
//       options: CarouselOptions(
//         autoPlay: true,
//         aspectRatio: 11 / 10,
//         height: heightScreen / 1.2,
//         enlargeCenterPage: true,
//         enlargeStrategy: CenterPageEnlargeStrategy.zoom,
//         pauseAutoPlayOnTouch: true,
//         autoPlayCurve: Curves.easeInOutSine,
//         enableInfiniteScroll: false,
//         viewportFraction: 0.6,
//       ),
//       itemCount: 4,
//       itemBuilder: (context, itemIndex, realIndex) {
//         return
//             // ignore: sized_box_for_whitespace
//             Row(children: [
//           const SizedBox(
//             width: 10,
//           ),
//           Column(children: [
//             SizedBox(
//               height: 250,
//               width: 250,
//               child: Center(
//                 child: Image.asset(
//                   Categorycard.catigo[itemIndex],
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//             ),
//             Container(
//               clipBehavior: Clip.hardEdge,
//               margin: const EdgeInsets.all(0.5),
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 49, 59, 135),
//                   borderRadius: BorderRadius.circular(20)),
//               height: heightScreen / 3.5,
//               width: widthScreen / 1.8,
//               child: Stack(
//                 clipBehavior: Clip.hardEdge,
//                 fit: StackFit.loose,
//                 children: [
//                   SvgPicture.string(
//                     Categorycard.images[itemIndex],
//                     fit: BoxFit.cover,
//                   ),
//                   Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 30, vertical: 20),
//                           child: Center(
//                             child: Text(
//                               Categorycard.illness[itemIndex],
//                               textAlign: TextAlign.center,
//                               textWidthBasis: TextWidthBasis.parent,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 255, 255, 255),
//                                   fontSize: font.FontSize.fs25,
//                                   fontWeight: font.FontWeightManager.Bold),
//                             ),
//                           ),
//                         ),
//                         ElevatedButton(
//                             onPressed: () {
//                               switch (itemIndex) {
//                                 case 0:
//                                   Get.toNamed(Routes.getDepressionRoute());
//                                   break;
//                                 case 1:
//                                   Get.toNamed(Routes.getBipolarRoute());
//                                   break;
//                                 case 3:
//                                   Get.toNamed(Routes.getPanicAttackRoute());
//                                   break;
//                                 case 4:
//                                   Get.toNamed(Routes.getAnxietyRoute());
//                                   break;
//                               }
//                             },
//                             child: const Text(
//                               "Start test",
//                               style: TextStyle(
//                                   fontWeight: font.FontWeightManager.Bold),
//                             )),
//                       ]),
//                 ],
//               ),
//             ),
//           ]),
//         ]);
//       },
//     );
//   }
// }
