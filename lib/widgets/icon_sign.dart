import 'package:flutter/material.dart';

import '../resources/color-manager.dart';

class IconSign extends StatelessWidget {
  final String text;
  const IconSign({
    Key? key,
    required this.heightScreen,
    required this.text,
  }) : super(key: key);

  final double heightScreen;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      // decoration: BoxDecoration(
      //     color: Color.fromARGB(228, 140, 152, 172),
      //     borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(110),
      //         bottomRight: Radius.circular(110))),
      height: heightScreen * 0.30,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/12.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: heightScreen * 0.15,
              child: Image.asset(
                "assets/images/log.png",
              ),
            ),
          ),
          Positioned(
            bottom: heightScreen * 0.03,
            left: widthScreen * 0.42,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Pacifico",
                color: ColorManager.buttonBase,
              ),
            ),
          )
        ],
      ),
    );
  }
}
