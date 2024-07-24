import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import '../../../resources/color-manager.dart';
import 'todo_control.dart';

class ToDo extends StatelessWidget {
  ToDo({Key? key});

  @override
  Widget build(BuildContext context) {
    final ToDoController control = Get.put(ToDoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Aims and Tasks",
          style: TextStyle(
            fontSize: 25,
            fontFamily: "Pacifico",
          ),
        ),
        backgroundColor: ColorManager.appBarPanicAttack,
        centerTitle: true,
      ),
      backgroundColor: ColorManager.primaryPanicAttack,
      body: Obx(() {
        if (control.loading.value) {
          return Center(
            child: Lottie.asset(
              "assets/imageJson/loading.json",
              fit: BoxFit.cover,
            ),
          );
        } else {
          List<String> aims = control.aim.value.split(', ');

          return ListView.builder(
            itemCount: aims.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (BuildContext context, index) {
              String aim = aims[index];
              List<String> goals = control.goalsMap[aim] ?? [];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AimItem(
                  aim: aim,
                  goals: goals,
                  onGoalDelete: (goal) {
                    control.deleteGoal(aim, goal);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}

class AimItem extends StatelessWidget {
  final String aim;
  final List<String> goals;
  final Function(String) onGoalDelete;

  const AimItem({
    Key? key,
    required this.aim,
    required this.goals,
    required this.onGoalDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    final ToDoController control = Get.put(ToDoController());
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: ColorManager.primaryPanicAttack,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.secondPanicAttack,
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: heightScreen * 0.4,
            child: ListView(
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Tasks",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: goals.map((goal) {
                    return InkWell(
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorManager.elementPanicAttack.withOpacity(0.9).withOpacity(0.5),
                          ),
                          height: heightScreen / 12,
                          width: widthScreen - widthScreen / 12,
                          clipBehavior: Clip.hardEdge,
                          child: Center(
                            child: Text(
                              goal,
                              style: TextStyle(
                                color: ColorManager.secondPanicAttack,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.elementPanicAttack,
        ),
        height: heightScreen / 11,
        width: widthScreen - widthScreen / 12,
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            aim,
            style: TextStyle(
              color: ColorManager.secondPanicAttack,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }
}
