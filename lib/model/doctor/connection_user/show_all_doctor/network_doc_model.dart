class Network2 {
  NetworkDoc? networkUser;

  Network2({required this.networkUser});

  Network2.fromJson(Map<String, dynamic> json) {
    networkUser = (json['network'] != null ? NetworkDoc.fromJson(json['network']) : null)!;
  }
}

class NetworkDoc {
  String? fName;
  String? lName;
  String? email;
  String? birth;
  String? gender;

  NetworkDoc(
      {
        required this.fName,
        required this.lName,
        required this.email,
        required this.birth,
        required this.gender,
      }
      );

  NetworkDoc.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    gender = json['gender'];
    birth = json['birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['email'] = email;
    data['gender'] = gender;
    data['birth'] = birth;
    return data;
  }
}


