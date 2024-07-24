class apiEndpoints {
  static final String protocol = "https";
  static final String ip = "selene-m-h.up.railway.app";
  static final String port = "443";
  static String baseUrl = 'https://selene-m-h.up.railway.app:443/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static _AuthEndPointsDoctot authEndpointsDoctor = _AuthEndPointsDoctot();
  static _AuthEndPointsUser authEndpointsUser = _AuthEndPointsUser();
}

class _AuthEndPointsDoctot {
  final String addToDO = 'to-do-list/set';
  final String showPatient = 'ai/show_my_patient';
}

class _AuthEndPointsUser {
  final String toDoUser = 'to-do-list/get';
}

class _AuthEndPoints {
  final String signupEmail = 'users/register';
  final String loginEmail = 'users/login';
  final String logoutEmail = 'users/logout';
  final String editEmail = 'users/edit';
  final String getEmail = 'users/profile/1doc@gmail.com';
  final String getPhoto = 'users/photo';
  final String updatePhoto = 'users/upload_photo';
  final String showdoclist = 'users/get_doctor_list';
}

//api for music
class apiMusic {
  static final String protocolMusic = "http";
  static final String ipMusic = "192.168.100.227";
  static final String portMusic = "8000";
  static String baseUrlMusic = '$protocolMusic://$ipMusic:$portMusic/';
  // http://127.0.0.1:8000/music/get_my_list
  static AuthMusicApi authEndpoints = AuthMusicApi();
}

class AuthMusicApi {
  final String musicGeneration = 'music/gen';
  final String getMusicGenerate = 'music/get_my_list';
  final String getMusicType = 'music/get_folder_list';
  final String getFinalMusic = 'music/get_music';
}