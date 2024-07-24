import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../resources/color-manager.dart';

class ContainerHomeWedgit extends StatelessWidget {
  const ContainerHomeWedgit({
    super.key,
    required this.heightScreen,
    required this.widthScreen,
    required this.img,
    required this.text1,
    required this.text2,
  });

  final double heightScreen;
  final double widthScreen;
  final String img;

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
          height: heightScreen * 0.25,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    ColorManager.appBarPanicAttack,
                    ColorManager.secondPanicAttack
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Positioned(
                    top: heightScreen * 0.02,
                    right: widthScreen * 0.01,
                    child: SizedBox(
                        width: widthScreen * 0.48,
                        height: heightScreen * 0.22,
                        child: Lottie.asset(
                          "assets/imageJson/${img}.json",
                          fit: BoxFit.cover,
                        ))),
                SizedBox(
                  width: widthScreen * 0.01,
                ),
                Positioned(
                  top: heightScreen * 0.1,
                  left: widthScreen * 0.04,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          text1,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Assistant",
                              color: ColorManager.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: heightScreen * 0.005,
                      ),
                      Text(
                        text2,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Assistant",
                            color: ColorManager.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}





    //  Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: SizedBox(
    //               height: heightScreen * 0.2,
    //               child: ListView.builder(
    //                 scrollDirection: Axis.horizontal,
    //                 itemCount: 5,
    //                 itemBuilder: (context, index) {
    //                   return Container(
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.all(
    //                         Radius.circular(30),
    //                       ),
    //                       color: ColorManager.elementPanicAttack,
    //                     ),
    //                     width: widthScreen * 0.5, // Adjust width as needed
    //                     margin: EdgeInsets.symmetric(horizontal: 8.0),
    //                     child: Column(children: [Image.asset("assets/images/")],),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ),