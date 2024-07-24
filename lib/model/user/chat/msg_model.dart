class Msg {
  String? email;
  String? token;
  String? recive;
  String? msg;

  Msg({required this.email, required this.token, required this.recive, required this.msg});

  Msg.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
    recive = json['recive'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['token'] = token;
    data['recive'] = recive;
    data['msg'] = msg;
    return data;
  }
}