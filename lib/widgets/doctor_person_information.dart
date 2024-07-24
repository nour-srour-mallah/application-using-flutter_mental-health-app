import 'package:flutter/material.dart';

import '../resources/color-manager.dart';

class PersonInformation extends StatelessWidget {
  final String question;
  final String information;

  const PersonInformation({
    Key? key,
    required this.question,
    required this.information,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                question,
                style: TextStyle(
                  fontSize: 17,
                  color: ColorManager.secondPanicAttack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: widthScreen * 0.005,
          ),
          Expanded(
            flex: 3,
            child: Text(
              information,
              style: TextStyle(
                fontSize: 17,
                color: ColorManager.secondPanicAttack,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
