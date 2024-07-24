import 'package:flutter/material.dart';

import '../resources/color-manager.dart';

class AnswerButton extends StatelessWidget {
  double heightScreen;
  double widthScreen;
  String answer;
  VoidCallback onTap;
  AnswerButton(
      {super.key,
      required this.heightScreen,
      required this.widthScreen,
      required this.answer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorManager.ansPanicAttack,
        ),
        height: heightScreen * 0.08,
        width: widthScreen * 0.42,
        clipBehavior: Clip.hardEdge,
        child: Center(
          child: Text(
            answer,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
