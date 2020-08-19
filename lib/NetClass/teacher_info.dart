class TeacherInfo {
  int code;
  String message;
  Data data;

  TeacherInfo({this.code, this.message, this.data});

  TeacherInfo.fromJson(Map<String, dynamic> json) {
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
  String id;
  String name;
  String gender;
  String department;
  String occupation;
  String work;
  String tel;

  Data(
      {this.id,
        this.name,
        this.gender,
        this.department,
        this.occupation,
        this.work,
        this.tel});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    department = json['department'];
    occupation = json['occupation'];
    work = json['work'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['department'] = this.department;
    data['occupation'] = this.occupation;
    data['work'] = this.work;
    data['tel'] = this.tel;
    return data;
  }
}
