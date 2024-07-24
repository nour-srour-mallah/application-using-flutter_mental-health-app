import 'package:flutter/material.dart';

import '../resources/color-manager.dart';

class SectionInfoDoctor extends StatelessWidget {
  final Icon icon;
  final String text;
  final Icon icon2;

  SectionInfoDoctor({
    required this.icon,
    required this.text,
    required this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: heightScreen * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorManager.elementPanicAttack,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                icon.icon,
                color: ColorManager.secondPanicAttack,
                size: 25,
              ),
              SizedBox(
                width: widthScreen * 0.05,
              ),
              Text(
                text,
                style: TextStyle(
                  color: ColorManager.secondPanicAttack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                icon2.icon,
                color: ColorManager.secondPanicAttack,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
