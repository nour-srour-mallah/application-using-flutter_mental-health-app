import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/color-manager.dart';
import '../../../widgets/widget_doctor/textfield_add_task.dart';

import 'generate_music_controler.dart';

class GenerateMusic extends StatelessWidget {
  const GenerateMusic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GenerateMusicController control = Get.put(GenerateMusicController());
    double heightScreen = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorManager.primaryBase,
          appBar: AppBar(
            backgroundColor: ColorManager.appBarBase,
            title: const Text(
              "Generate Music",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Shrikhand",
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Container(
                height: heightScreen * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.appBarBase,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: heightScreen * 0.22,
                      width: double.infinity,
                      child: Center(
                        child: Image.asset(
                          "assets/images/musicdoctor.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Generate Music",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Shrikhand",
                          color: ColorManager.textFielTextBase,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: heightScreen * 0.06,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(
                  () => Container(
                    height: 60,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: ColorManager.textFieldBase,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButton<String>(
                        hint: Text(
                          "Patient Selection",
                          style:
                              TextStyle(color: ColorManager.textFielTextBase),
                        ),
                        isExpanded: true,
                        underline: SizedBox(),
                        value: control.selectedPatient.value.isEmpty
                            ? null
                            : control.selectedPatient.value,
                        onChanged: (newValue) {
                          control.upDateSelectedPatient(newValue.toString());
                        },
                        dropdownColor: ColorManager.textFieldBase,
                        icon: Icon(Icons.arrow_drop_down),
                        elevation: 60,
                        items: (control.emailPatients.isNotEmpty)
                            ? control.emailPatients.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList()
                            : [],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: heightScreen * 0.05,
              ),
              TextfieldAddTask(
                label: "Description Music",
                controller: control.descriptionController,
              ),
              SizedBox(
                height: heightScreen * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(
                  () => Container(
                    height: 60,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: ColorManager.textFieldBase,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButton<String>(
                        hint: Text(
                          "Select Illness",
                          style:
                              TextStyle(color: ColorManager.textFielTextBase),
                        ),
                        isExpanded: true,
                        underline: SizedBox(),
                        value: control.selectedItem.value.isEmpty
                            ? null
                            : control.selectedItem.value,
                        onChanged: (newValue) {
                          control.upDateSelectedItem(newValue.toString());
                        },
                        dropdownColor: ColorManager.textFieldBase,
                        icon: Icon(Icons.arrow_drop_down),
                        elevation: 60,
                        items: <String>['depression', 'panic attack', 'Bipolar']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: heightScreen * 0.07,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.buttonBase,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    print("Check if send true");
                    print(control.selectedPatient);
                    print(control.selectedItem);
                    Get.defaultDialog(
                      titlePadding: EdgeInsets.all(10),
                      backgroundColor: ColorManager.elementBase,
                      title: 'Success Send',
                      contentPadding: EdgeInsets.all(10),
                      content: Text("Press OK to continue"),
                      textConfirm: 'OK',
                      confirmTextColor: Colors.white,
                      buttonColor: ColorManager.buttonBase,
                      onConfirm: () {
                        print('Dialog confirmed');
                        Get.back();
                      },
                    );
                    print("You pressed send. Please wait.");
                    control.postMusic();
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
