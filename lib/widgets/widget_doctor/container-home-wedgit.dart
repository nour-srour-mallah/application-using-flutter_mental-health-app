import 'package:flutter/material.dart';

import '../../resources/color-manager.dart';

class ContainerHomeDocWedgit extends StatelessWidget {
  const ContainerHomeDocWedgit({
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
                  colors: [ColorManager.secondBase, ColorManager.appBarBase]),
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
                        child: Image.asset(
                          "assets/images/${img}.png",
                          fit: BoxFit.cover,
                        ))),
                SizedBox(
                  width: widthScreen * 0.01,
                ),
                Positioned(
                  top: heightScreen * 0.1,
                  left: widthScreen * 0.03,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        text1,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Assistant",
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: heightScreen * 0.005,
                      ),
                      SizedBox(
                        width: widthScreen * 0.4,
                        child: Text(
                          text2,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Assistant",
                              color: ColorManager.white,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.clip,
                        ),
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
