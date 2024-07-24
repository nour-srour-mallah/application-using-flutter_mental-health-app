import 'package:get/get.dart';

import '../model/doctor/add_task/add_task_screen.dart';
import '../model/doctor/connection_user/show_all_doctor/more_inf_user/more_info.dart';
import '../model/doctor/connection_user/show_all_doctor/show_all.dart';
import '../model/doctor/generate_music/generate_music_screen.dart';
import '../model/doctor/home_page/home_page_screen.dart';
import '../model/splash_screen/splash_screen.dart';

import '../model/user/chat/chat_one.dart';

import '../model/user/disease_testing/depression/depression_screen.dart';
import '../model/user/disease_testing/depression/result_screen.dart';
import '../model/user/disease_testing/depression_bipolar/result_screen.dart';
import '../model/user/disease_testing/depression_bipolar/test_depression_bipolar_screen.dart';
import '../model/user/disease_testing/panic_attack/result_screen.dart';
import '../model/user/disease_testing/panic_attack/test_panicattack_screen.dart';

import '../model/user/doctor/show_all_doctor/show_all.dart';

import '../model/user/doctor/definition_doctot/information_doctor.dart';
import '../model/user/home/about_screen.dart';
import '../model/user/home/home_screen.dart';

import '../model/user/music/home/music_home_screen.dart';

import '../model/user/music/home/show_quran.dart';
import '../model/user/music/show_music/show_all_music.dart';
import '../model/user/quiz/quiz_screen.dart';
import '../model/sign_in/sign_in_screen.dart';
import '../model/sign_up/sign_up_screen.dart';
import '../model/sign_up/sign_up_screen2.dart';
import '../model/user/update_info_profile/update_info_screen.dart';
import '../model/doctor/connection_user/show_all_doctor/information_user.dart';
import '../model/user/to_do/todo_screen.dart';

class Routes {
  static String splashScreen = "/";
  static String signIn = "/signIn";
  static String signUp = "/signUp";
  static String signUpTwo = "/signUpTwo";
//route user
  static String home = "/home";
  static String about = "/about";
  static String musicHome = "/musicHome";
  static String playerMusic = "/playerMusic";
  static String showMusic = "/showMusic";
  static String updateProfile = "/updateProfile";
  static String infoDoctor = "/infoDoctor";
  static String infoUser = "/infoUser";
  static String showAllDoctor = "/showAllDoctor";
  static String categories = "/categories";
  static String quiz = "/quiz";
  static String todo = "/todo";
  static String chat = "/chat";
  static String paincAttack = "/paincAttack";
  static String depression = "/depression";
  static String quran = "/quran";
  static String allMusicFolder = "/allMusicFolder";
  static String showResultScreen = "/showResultScreen";
  static String resultPanic = "/resultPanic";
  static String resultDepression = "/resultDepression";
  static String resultDep = "/resultDep";
  static String dep = "/dep";
  static String moreInfo = "/moreInfo";

//rout doctor
  static String homeDoctor = "/homeDoctor";
  static String allUser = "/allUser";
  static String addTask = "/addTask";
  static String generateMusic = "/generateMusic";

  static String getSplashScreenRoute() => splashScreen;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getSignUpTwoRoute() => signUpTwo;
//user
  static String getHomeRoute() => home;
  static String getAboutRoute() => about;
  static String getMusicHomeRoute() => musicHome;
  static String getPlayerMusicRoute() => playerMusic;
  static String getShowAllMusicRoute() => showMusic;
  static String getUpdateProfileRoute() => updateProfile;
  static String getInfoDoctorRoute() => infoDoctor;
  static String getInfoUserRoute() => infoUser;
  static String getShowAllDoctorRoute() => showAllDoctor;
  static String getCategoriesRoute() => categories;
  static String getQuizRoute() => quiz;

  static String getToDoRoute() => todo;
  static String getChatRoute() => chat;
  static String getPaincAttackRoute() => paincAttack;
  static String getDepressionRoute() => depression;
  static String getQuranRoute() => quran;
  static String getAllMusicFolderRoute() => allMusicFolder;
  static String getShowResultScreenRoute() => showResultScreen;
  static String getShowResultPanicRoute() => resultPanic;
  static String getShowResultDepressionRoute() => resultDepression;
  static String getShowResultDepRoute() => resultDep;
  static String getDepRoute() => dep;
  static String getMoreInfoRoute() => moreInfo;
//doctor
  static String getHomeDoctorRoute() => homeDoctor;
  static String geAllUserRoute() => allUser;
  static String geAddTaskRoute() => addTask;
  static String getGenerateMusicRoute() => generateMusic;

  //list rout
  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: (() => SplahScreen())),
    GetPage(name: signIn, page: (() => SignInScreen())),
    GetPage(name: signUp, page: (() => SignUpScreen())),
    GetPage(name: signUpTwo, page: (() => SignUpScreenTwo())),
//user
    GetPage(name: home, page: (() => HomeScreen())),
    GetPage(name: about, page: (() => AboutScreen())),
    GetPage(name: musicHome, page: (() => MusicHomeScreen())),
    //GetPage(name: playerMusic, page: (() => MusicPlayer())),
    GetPage(name: showMusic, page: (() => ShowAllMusic())),
    GetPage(name: updateProfile, page: (() => const UpdateProfile())),
    GetPage(name: infoUser, page: (() => UserInformation())),
    GetPage(name: infoDoctor, page: (() => DoctorInformation())),
    GetPage(name: showAllDoctor, page: (() => ShowAllDoctor())),
    //GetPage(name: categories, page: (() => const Categories())),
    GetPage(name: quiz, page: (() => QuestionEXP())),
    GetPage(name: todo, page: (() => ToDo())),
    GetPage(name: chat, page: (() => ChatOne())),
    GetPage(name: paincAttack, page: (() => PanicAttackTest())),
    GetPage(name: depression, page: (() => DepressionBipolarTest())),
    GetPage(name: quran, page: (() => ShowAllQuran())),

    GetPage(name: resultPanic, page: (() => ResultPanicAttack())),
    GetPage(name: resultDepression, page: (() => ResultDeprission())),
    GetPage(name: resultDep, page: (() => ResultDep())),
    GetPage(name: dep, page: (() => DepressionTest())),
    GetPage(name: moreInfo, page: (() => MoreInfo())),
    //GetPage(name: allMusicFolder, page: (() => ShowAllMusicFolder(folderName: 'name',))),

    //doctor
    GetPage(name: homeDoctor, page: (() => HomeDoctorScreen())),
    GetPage(name: allUser, page: (() => ShowUserConn())),
    GetPage(name: addTask, page: (() => AddTask())),
    GetPage(name: generateMusic, page: (() => GenerateMusic())),
  ];
}
