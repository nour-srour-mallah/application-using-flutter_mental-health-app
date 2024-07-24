import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import '../../../../resources/color-manager.dart';

import '../../../../widgets/result_illness_dont_have.dart';
import '../../../../widgets/result_illnesses_have.dart';

class ResultDep extends StatelessWidget {
  ResultDep({super.key});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final deppresionResult = box.read('Deppresion');

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
                if (deppresionResult != null)
                  if (deppresionResult)
                    HaveIllnesses(
                      heightScreen: heightScreen,
                      name: 'Depression',
                    )
                  else
                    DontHaveIllnesses(
                      heightScreen: heightScreen,
                      name: 'Depression',
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
