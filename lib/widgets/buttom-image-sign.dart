import 'package:flutter/material.dart';

class BottomImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          "assets/images/3.png",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Image.asset(
          "assets/images/4.png",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
