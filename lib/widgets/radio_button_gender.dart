import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/sign_up/sign_up_controller.dart';
import '../resources/color-manager.dart';

class RadioButtonGender extends StatelessWidget {
  final String value;
  final String title;

  const RadioButtonGender(
      {super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return GetBuilder<SignUpController>(
      builder: (signUpController) {
        return InkWell(
          onTap: () => signUpController.setGenderType(value),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: signUpController.genderType,
                onChanged: (String? value) {
                  signUpController.setGenderType(value!);
                },
                activeColor: ColorManager.buttonBase,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(title)
            ],
          ),
        );
      },
    );
  }
}

// class RadioButtonPerson extends StatelessWidget {
//   final String value;
//   final String title;

//   const RadioButtonPerson({
//     Key? key,
//     required this.value,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Get.put(SignUpController());
//     return GetBuilder<SignUpController>(
//       builder: (signUpController) {
//         return InkWell(
//           onTap: () => signUpController.setPersonType(value),
//           child: Row(
//             children: [
//               Radio(
//                 value: value,
//                 groupValue: signUpController.personType,
//                 onChanged: (String? value) {
//                   signUpController.setPersonType(value!);
//                 },
//                 activeColor: ColorManager.buttonBase,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(title)
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
