import 'package:flutter/material.dart';

import '../resources/color-manager.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String action;

  const SectionHeader({
    super.key,
    required this.title,
    this.action = "view more",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ColorManager.sectioHeaderPanicAttack,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: ColorManager.white, fontWeight: FontWeight.bold),
              ),
              Text(
                action,
                style: TextStyle(
                  color: ColorManager.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
