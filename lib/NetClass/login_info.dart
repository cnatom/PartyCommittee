class LoginInfo {
  int code;
  String message;
  Data data;

  LoginInfo({this.code, this.message, this.data});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String token;
  String name;
  String oldIp;
  String newIp;

  Data({this.token, this.name, this.oldIp, this.newIp});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    oldIp = json['oldIp'];
    newIp = json['newIp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['name'] = this.name;
    data['oldIp'] = this.oldIp;
    data['newIp'] = this.newIp;
    return data;
  }
}
