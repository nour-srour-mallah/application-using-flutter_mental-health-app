import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import '../../../../resources/color-manager.dart';

import '../../../../widgets/result_illness_dont_have.dart';
import '../../../../widgets/result_illnesses_have.dart';

class ResultPanicAttack extends StatelessWidget {
  ResultPanicAttack({super.key});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final panicAttackResult = box.read('panicAttack');

    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Panic Attack Results
                if (panicAttackResult != null)
                  if (panicAttackResult)
                    HaveIllnesses(
                      heightScreen: heightScreen,
                      name: 'panic Attack',
                    )
                  else
                    DontHaveIllnesses(
                      heightScreen: heightScreen,
                      name: 'panic Attack',
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
