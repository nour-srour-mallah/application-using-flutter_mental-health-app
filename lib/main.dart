// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import 'firebase_options.dart';

//import 'notifications/push_notification.dart';
import 'resources/route.dart';

///////////////////////////////for app
class apiEndpoints {
  static final String protocol = "https";
  static final String ip = "selene-m-h.up.railway.app";
  static final String port = "443";
  static String baseUrl = 'https://selene-m-h.up.railway.app:443/';

  static AuthEndPoints authEndpoints = AuthEndPoints();
}

class AuthEndPoints {
  final String signupEmail = 'users/register';
  final String loginEmail = 'users/login';
  final String logoutEmail = 'users/logout';
  final String todo = 'to_do_list/set';
  final String rate = 'users/add-rate';
  final String network = 'chat/network';
// final String todouser = 'to-do-list/get';
}

// //////////////////////////////////////for notification
// final navigatorKey = GlobalKey<NavigatorState>();
// // function to lisen to background changes
// Future _firebaseBackgroundMessage(RemoteMessage message) async {
//   if (message.notification != null) {
//     print("Some notification Received");
//   }
// }

void main() async {
//   //////////////////////////////////////for notification
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // on background notification tapped
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     if (message.notification != null) {
//       print("Background Notification Tapped");
//       Get.toNamed(Routes.getHomeRoute());
//     }
//   });

//   PushNotifications.init();
//   PushNotifications.localNotiInit();
// // Listen to background notifications
//   FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
//   // for handling in terminated state
//   final RemoteMessage? message =
//       await FirebaseMessaging.instance.getInitialMessage();

//   if (message != null) {
//     print("Launched from terminated state");
//     Future.delayed(Duration(seconds: 1), () {
//       Get.toNamed(Routes.getHomeRoute());
//     });
//   }

  // // to handle foreground notifications
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   String payloadData = jsonEncode(message.data);
  //   print("Got a message in foreground");
  //   if (message.notification != null) {
  //     PushNotifications.showSimpleNotification(
  //         title: message.notification!.title!,
  //         body: message.notification!.body!,
  //         payload: payloadData);
  //   }
  // });
  ///////////////////////////for app
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //initial splash change when add ************
      initialRoute: Routes.getSplashScreenRoute(),
      getPages: Routes.routes,
    );
  }
}
