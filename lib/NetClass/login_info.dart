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
  String oldIp;
  String ip;
  String token;

  Data({this.oldIp, this.ip, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    oldIp = json['oldIp'];
    ip = json['本次登录ip'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldIp'] = this.oldIp;
    data['本次登录ip'] = this.ip;
    data['token'] = this.token;
    return data;
  }
}
