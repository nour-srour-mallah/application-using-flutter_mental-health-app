import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../resources/color-manager.dart';
import '../../../widgets/widget_doctor/textfield_add_task.dart';
import 'add_task_controller.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddTaskController control = Get.put(AddTaskController());
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
              "Patient Tasks",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Shrikhand",
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(
            () => ListView(
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
                            "assets/images/add.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Add goal and task",
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
                  height: heightScreen * 0.05,
                ),
                //////////////////////////////////////////////////////////////
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
                            "patient selection",
                            style:
                                TextStyle(color: ColorManager.textFielTextBase),
                          ),
                          isExpanded: true,
                          underline: SizedBox(),
                          value: control.selectedItem.value == ""
                              ? null
                              : control.selectedItem.value,
                          onChanged: (newValue) {
                            control.upDateSelectedItem(newValue.toString());
                          },
                          dropdownColor: ColorManager.textFieldBase,
                          icon: Icon(Icons.arrow_drop_down),
                          elevation: 60,
                          items: (GetStorage().read('emailPatients')
                                      as List<dynamic>? ??
                                  [])
                              .map((value) {
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
                ///////////////////////////////////////////////////////////////

                SizedBox(
                  height: heightScreen * 0.03,
                ),
                TextfieldAddTask(
                  label: "add goal",
                  controller: control.aimController,
                ),
                SizedBox(
                  height: heightScreen * 0.03,
                ),
                TextfieldAddTask(
                  label: "add task 1",
                  controller: control.goalController,
                ),
                SizedBox(
                  height: heightScreen * 0.03,
                ),
                if (control.showTask2.value)
                  TextfieldAddTask(
                    label: "add task 2",
                    controller: control.goalController2,
                  ),
                SizedBox(
                  height: heightScreen * 0.02,
                ),
                SizedBox(
                  height: heightScreen * 0.05,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: FloatingActionButton(
                      backgroundColor: ColorManager.appBarBase,
                      onPressed: () {
                        control.showTask2.toggle();
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightScreen * 0.05,
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
                      print("you press send please wait");
                      print("check if send true");

                      print(control.selectedItem);
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
                      control.postDataGoal();
                    },
                    child: Text(
                      'send',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
