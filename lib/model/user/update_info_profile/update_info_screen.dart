// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart' hide Action;
// import 'package:image_picker/image_picker.dart';
//
// import '../../../resources/color-manager.dart';
// import '../../../services/endpoints_api.dart';
// import '../../../widgets/textfield_edit_profile.dart';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
//
// import '../../../resources/color-manager.dart';
// import '../../../services/endpoints_api.dart';
// import '../../../widgets/textfield_edit_profile.dart';
//
// class UpdateProfile extends StatefulWidget {
//   const UpdateProfile({Key? key}) : super(key: key);
//
//   @override
//   State<UpdateProfile> createState() => _UpdateProfileState();
// }
//
// class _UpdateProfileState extends State<UpdateProfile> {
//   String? photo;
//   List<String>? arr2;
//   final _picker = ImagePicker();
//   Uint8List? bytes;
//   String? base64Image;
//   File? _image;
//   late Map<String, Color> colorScheme;
//   final url =
//       apiEndpoints.baseUrl + apiEndpoints.authEndpoints.getPhoto + "/${GetStorage().read('email')}";
//
//   @override
//   void initState() {
//     super.initState();
//     String userType = GetStorage().read('type');
//     colorScheme = ColorManager.getColorScheme(userType);
//   }
//
//   Future<void> pickerImage() async {
//     final XFile? myfile = await _picker.pickImage(source: ImageSource.gallery);
//     if (myfile != null) {
//       setState(() {
//         _image = File(myfile.path);
//       });
//     }
//   }
//
//   void encodeImageToBase64(File image) {
//     List<int> imageBytes = image.readAsBytesSync();
//     base64Image = base64Encode(imageBytes);
//     print(base64Image);
//   }
//
//   void clickUpdateButton() {
//     setState(() {
//       List<String> arr1 = ["first_name", "last_name", "password", "country"];
//       updateProfileValues(arr1, arr2!);
//     });
//   }
//
//   Future<void> updateProfileValues(List<String> arr1, List<String> arr2) async {
//     final apiUrl = apiEndpoints.baseUrl + apiEndpoints.authEndpoints.editEmail;
//
//     final email = GetStorage().read('email');
//     final token = GetStorage().read('token');
//
//     final requestBody = {
//       'email': email,
//       'token': token,
//       'params': arr1,
//       'new_values': arr2,
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(requestBody),
//       ).timeout(
//         const Duration(seconds: 50),
//         onTimeout: () {
//           return http.Response('Error', 408);
//         },
//       );
//       print(response.body);
//       if (response.statusCode == 200) {
//         print('Profile values updated successfully!');
//       } else {
//         print('Error updating profile values. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception occurred: $e');
//     }
//   }
//
//   Future<void> uploadBase64Image(String base64Image) async {
//     final apiUrl = "https://selene-m-h.up.railway.app/users/upload_photo/${GetStorage().read('email')}";
//
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'photo': base64Image}),
//     );
//     print(response.body);
//
//     if (response.statusCode == 200) {
//       print('Image uploaded successfully!');
//     } else {
//       print('Error uploading image. Status code: ${response.statusCode}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double heightScreen = MediaQuery.of(context).size.height;
//     double widthScreen = MediaQuery.of(context).size.width;
//     TextEditingController fnamec = TextEditingController(text: '');
//     TextEditingController lnamec = TextEditingController(text: '');
//     TextEditingController passwordc = TextEditingController(text: '');
//     TextEditingController countryc = TextEditingController(text: '');
//
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: colorScheme['primary']!,
//         appBar: AppBar(
//           elevation: 0.32,
//           title: const Text(
//             "Edit Profile",
//             style: TextStyle(
//               fontSize: 23,
//               fontFamily: "Pacifico",
//             ),
//           ),
//           backgroundColor: colorScheme['appBar']!,
//           centerTitle: true,
//         ),
//         body: Container(
//           child: GestureDetector(
//             onTap: () {
//               FocusScope.of(context).unfocus();
//             },
//             child: ListView(
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       height: heightScreen * 0.2,
//                       decoration: BoxDecoration(
//                         color: colorScheme['appBar']!,
//                         borderRadius: const BorderRadius.only(
//                           bottomLeft: Radius.circular(70),
//                           bottomRight: Radius.circular(70),
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 60),
//                         child: CircleAvatar(
//                           backgroundColor: colorScheme['appBar']!,
//                           radius: 70,
//                           child: CircleAvatar(
//                             radius: 65,
//                             backgroundColor: colorScheme['primary']!,
//                             child: ClipOval(
//                               child: _image != null
//                                   ? Image.file(
//                                 _image!,
//                                 fit: BoxFit.cover,
//                                 width: 130,
//                                 height: 130,
//                               )
//                                   : url != null
//                                   ? Image.network(
//                                 url,
//                                 fit: BoxFit.cover,
//                                 width: 130,
//                                 height: 130,
//                               )
//                                   : const Text('No photo'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: widthScreen / 2.8,
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: colorScheme['appBar']!,
//                           boxShadow: [
//                             BoxShadow(
//                               spreadRadius: 3,
//                               blurRadius: 1,
//                               color: colorScheme['primary']!,
//                               offset: const Offset(0, 0),
//                             ),
//                           ],
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             width: 3,
//                             color: colorScheme['appBar']!,
//                           ),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.white, size: 17),
//                           onPressed: () {
//                             print("Edit image clicked");
//                             pickerImage();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         TextFieldEdit(
//                           controller: fnamec,
//                           icon: Icons.person,
//                           hint: GetStorage().read('first_name'),
//                           label: "First Name",
//                         ),
//                         SizedBox(height: heightScreen * 0.04),
//                         TextFieldEdit(
//                           controller: lnamec,
//                           icon: Icons.person,
//                           hint: GetStorage().read('last_name'),
//                           label: "Last Name",
//                         ),
//                         SizedBox(height: heightScreen * 0.04),
//                         TextFieldEdit(
//                           controller: countryc,
//                           label: "Country",
//                           icon: Icons.email,
//                           hint: GetStorage().read('country'),
//                         ),
//                         SizedBox(height: heightScreen * 0.04),
//                         TextFieldEdit(
//                           controller: passwordc,
//                           label: "Password",
//                           icon: Icons.lock,
//                           hint: GetStorage().read('password'),
//                         ),
//                         SizedBox(height: heightScreen * 0.02),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 120),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: colorScheme['second']!,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_image != null) {
//                                 encodeImageToBase64(_image!);
//                                 photo = "data:image/jpeg;base64," + base64Image!;
//                               } else {
//                                 photo = url;
//                               }
//
//                               setState(() {
//                                 if (_image != null) {
//                                   uploadBase64Image(photo!);
//                                 }
//                               });
//
//                               arr2 = [
//                                 fnamec.text,
//                                 lnamec.text,
//                                 passwordc.text,
//                                 countryc.text,
//                               ];
//                               clickUpdateButton();
//                             },
//                             child: const Text(
//                               'Edit',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../../resources/color-manager.dart';
import '../../../services/endpoints_api.dart';
import '../../../widgets/textfield_edit_profile.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String? photo;
  final _picker = ImagePicker();
  Uint8List? bytes;
  String? base64Image;
  File? _image;
  late Map<String, Color> colorScheme;
  final url =
      apiEndpoints.baseUrl + apiEndpoints.authEndpoints.getPhoto + "/${GetStorage().read('email')}";

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String userType = GetStorage().read('type');
    colorScheme = ColorManager.getColorScheme(userType);
  }

  Future<void> pickerImage() async {
    final XFile? myfile = await _picker.pickImage(source: ImageSource.gallery);
    if (myfile != null) {
      setState(() {
        _image = File(myfile.path);
      });
    }
  }

  void encodeImageToBase64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    print(base64Image);
  }

  Future<void> updateProfileValues(List<String> arr1, List<String> arr2) async {
    final apiUrl = apiEndpoints.baseUrl + apiEndpoints.authEndpoints.editEmail;

    final email = GetStorage().read('email');
    final token = GetStorage().read('token');

    final requestBody = {
      'email': email,
      'token': token,
      'params': arr1,
      'new_values': arr2,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      ).timeout(
        const Duration(seconds: 50),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        print('Profile values updated successfully!');
      } else {
        print('Error updating profile values. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  Future<void> uploadBase64Image(String base64Image) async {
    final apiUrl = "https://selene-m-h.up.railway.app/users/upload_photo/${GetStorage().read('email')}";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'photo': base64Image}),
    );
    print(response.body);

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Error uploading image. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorScheme['primary']!,
        appBar: AppBar(
          elevation: 0.32,
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 23,
              fontFamily: "Pacifico",
            ),
          ),
          backgroundColor: colorScheme['appBar']!,
          centerTitle: true,
        ),
        body: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: heightScreen * 0.2,
                      decoration: BoxDecoration(
                        color: colorScheme['appBar']!,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: CircleAvatar(
                          backgroundColor: colorScheme['appBar']!,
                          radius: 70,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: colorScheme['primary']!,
                            child: ClipOval(
                              child: _image != null
                                  ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                                width: 130,
                                height: 130,
                              )
                                  : url != null
                                  ? Image.network(
                                url,
                                fit: BoxFit.cover,
                                width: 130,
                                height: 130,
                              )
                                  : const Text('No photo'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: widthScreen / 2.8,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: colorScheme['appBar']!,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 1,
                              color: colorScheme['primary']!,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3,
                            color: colorScheme['appBar']!,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white, size: 17),
                          onPressed: () {
                            print("Edit image clicked");
                            pickerImage();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFieldEdit(
                          controller: fnameController,
                          icon: Icons.person,
                          hint: GetStorage().read('first_name'),
                          label: "First Name",
                        ),
                        SizedBox(height: heightScreen * 0.04),
                        TextFieldEdit(
                          controller: lnameController,
                          icon: Icons.person,
                          hint: GetStorage().read('last_name'),
                          label: "Last Name",
                        ),
                        SizedBox(height: heightScreen * 0.04),
                        TextFieldEdit(
                          controller: countryController,
                          label: "Country",
                          icon: Icons.email,
                          hint: GetStorage().read('country'),
                        ),
                        SizedBox(height: heightScreen * 0.04),
                        TextFieldEdit(
                          controller: passwordController,
                          label: "Password",
                          icon: Icons.lock,
                          hint: GetStorage().read('password'),
                        ),
                        SizedBox(height: heightScreen * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme['second']!,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (_image != null) {
                                encodeImageToBase64(_image!);
                                photo = "data:image/jpeg;base64," + base64Image!;
                              } else {
                                photo = url;
                              }

                              if (_image != null) {
                                uploadBase64Image(photo!);
                              }

                              final arr1 = ["first_name", "last_name", "password", "country"];
                              final arr2 = [
                                fnameController.text,
                                lnameController.text,
                                passwordController.text,
                                countryController.text,
                              ];

                              // Print values before sending to API
                              print('Updating profile with values:');
                              print('First Name: ${fnameController.text}');
                              print('Last Name: ${lnameController.text}');
                              print('Password: ${passwordController.text}');
                              print('Country: ${countryController.text}');

                              updateProfileValues(arr1, arr2);
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
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
