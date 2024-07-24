// import 'dart:convert';
// import '../../../../main.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'model_get_doc_list.dart';
// import '../../../../resources/color-manager.dart';
// import '../../../../resources/route.dart';
// import '../../../../widgets/card_show_doctor.dart';
// import 'package:http/http.dart' as http;

// class ShowAllDoctor extends StatefulWidget {
//   const ShowAllDoctor({super.key});

//   @override
//   State<ShowAllDoctor> createState() => _ShowAllDoctorState();
// }

// class _ShowAllDoctorState extends State<ShowAllDoctor> {
//   // final GetAllDocsController docController =
//   // Get.put(GetAllDocsController());
//   List<doc>? doctors;

//   @override
//   void initState() {
//     super.initState();
//     getDocs().then((value) {
//       if (value != null) {
//         setState(() {
//           doctors = value;
//         });
//       }
//     });
//   }

//   // late int lengthOfList;

// //   Future<int> getListLength() async{
// //     return  await doctors.then((value) {
// //       return value.length;
// //     });
// //   }
// //
// // //inside initState method
// //   getListLength().then((value) {
// //   if (value != null)
// //   setState(() {
// //   lengthOfList = value;
// //   });
// //   });

//   Future<List<doc>?> getDocs() async {
//     var response = await http.get(
//       Uri.parse("https://selene-m-h.up.railway.app:443/users/get_doctor_list"),
//     );
//     doctors = [];
//     if (response.statusCode == 200) {
//       fetchDocs(response.body);
//       // var responseJson = json.decode(response.body);
//       // return (responseJson['doctors']).map((m) => new docList.fromJson(m)).toList();
//     }
//   }

//   void fetchDocs(String jsonString) {
//     var data = jsonDecode(jsonString);
//     var docs = data['doctors'] as List<dynamic>;
//     for (final doc in docs) {
//       setState(() {
//         doctors?.add(doc['doctors']);
//       });
//     }
//   }

//   @override
//   build(BuildContext context) async {
// //     int len=0;
// // if(doctors != null){
// //   len = doctors!.length;
// // }else{
// //   len = 0;
// // }
//     // future: fetchDocs(),
//     // builder: (context, snapshot) {
//     //   if (snapshot.connectionState == ConnectionState.waiting) {
//     //     return CircularProgressIndicator();
//     //   } else if (snapshot.hasError) {
//     //     return Text('Error: ${snapshot.error}');
//     //   } else {
//     //     doctors = snapshot.data ;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: ColorManager.primaryPanicAttack,
//         appBar: AppBar(
//           title: const Text(
//             "All Doctor",
//             style: TextStyle(
//               fontSize: 20,
//               fontFamily: "Pacifico",
//             ),
//           ),
//           backgroundColor: ColorManager.appBarPanicAttack,
//           centerTitle: true,
//         ),
//         body: ListView.builder(
//           itemCount: doctors!.length,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 //move to information doctor
//                 Get.toNamed(Routes.getInfoDoctorRoute());
//               },
//               child: ShowDoctor(doctor: doctors![index]),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../chat/model_chat.dart';
import '../show_all_doctor/show_all_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model_get_doc_list.dart';
import '../../../../resources/color-manager.dart';
import '../../../../resources/route.dart';
import '../../../../widgets/card_show_doctor.dart';
import 'package:http/http.dart' as http;

class ShowAllDoctor extends StatefulWidget {
  const ShowAllDoctor({super.key});

  @override
  State<ShowAllDoctor> createState() => _ShowAllDoctorState();
}

class _ShowAllDoctorState extends State<ShowAllDoctor> {
  final AuthController authController = Get.put(AuthController());

  final box = GetStorage();
  List<doc>? doctors;

  @override
  void initState() {
    super.initState();
    getDocs().then((value) {
      if (value != null) {
        setState(() {
          doctors = value;
        });
      }
    });
  }

  Future<void> SelectDoc() async {
    final url = apiEndpoints.baseUrl+"ai/select_doctor"; // Replace with your API endpoint
    final Map<String, dynamic> data = {
      'email': GetStorage().read("email"),
      'token': GetStorage().read("token"),
      'doctor': GetStorage().read("currentDoc"),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully!');
      // Handle the response data here if needed
    } else {
      print('Error sending data. Status code: ${response.statusCode}');
    }
  }

  Future<List<doc>?> getDocs() async {
    var response = await http.get(
      Uri.parse("https://selene-m-h.up.railway.app:443/users/get_doctor_list"),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var docs = data['doctors'] as List<dynamic>;
      return docs.map((json) => doc.fromJson(json)).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        appBar: AppBar(
          title: const Text(
            "All Doctor",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Pacifico",
            ),
          ),
          backgroundColor: ColorManager.appBarPanicAttack,
          centerTitle: true,
        ),
        body: doctors == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: doctors!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                AuthController.logout();
                box.write("currentDoc", doctors![index].email);
                box.write("DocName", "${doctors![index].firstName} ${doctors![index].lastName}");
                box.write("DocRate", doctors![index].rate);
                box.write("DocAddress", doctors![index].clinic_address);
                box.write("DocSpecial", doctors![index].specialization);
                SelectDoc();
                Get.toNamed(Routes.getHomeRoute());
              },
              child: ShowDoctor(doctor: doctors![index]),
            );
          },
        ),
      ),
    );
  }
}
