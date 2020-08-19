class StudentInfo {
  int code;
  String message;
  Data data;

  StudentInfo({this.code, this.message, this.data});

  StudentInfo.fromJson(Map<String, dynamic> json) {
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
  String pinyin;
  String idCard;
  String grade;
  String department;
  String classes;
  String national;
  String educationBackground;
  String graduatedSchool;
  String address;
  String dormitory;
  String email;
  String phone;
  String awards;
  String emergencyContact;
  String emergencyPhone;
  String aid;
  String psychologicalLevel;
  String counsellorName;
  String counsellorNum;
  String counsellorPhone;
  String politicalStatus;
  String originLocation;
  String state;
  String note;

  Data(
      {this.id,
        this.name,
        this.gender,
        this.pinyin,
        this.idCard,
        this.grade,
        this.department,
        this.classes,
        this.national,
        this.educationBackground,
        this.graduatedSchool,
        this.address,
        this.dormitory,
        this.email,
        this.phone,
        this.awards,
        this.emergencyContact,
        this.emergencyPhone,
        this.aid,
        this.psychologicalLevel,
        this.counsellorName,
        this.counsellorNum,
        this.counsellorPhone,
        this.politicalStatus,
        this.originLocation,
        this.state,
        this.note});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    pinyin = json['pinyin'];
    idCard = json['idCard'];
    grade = json['grade'];
    department = json['department'];
    classes = json['classes'];
    national = json['national'];
    educationBackground = json['educationBackground'];
    graduatedSchool = json['graduatedSchool'];
    address = json['address'];
    dormitory = json['dormitory'];
    email = json['email'];
    phone = json['phone'];
    awards = json['awards'];
    emergencyContact = json['emergencyContact'];
    emergencyPhone = json['emergencyPhone'];
    aid = json['aid'];
    psychologicalLevel = json['psychologicalLevel'];
    counsellorName = json['counsellorName'];
    counsellorNum = json['counsellorNum'];
    counsellorPhone = json['counsellorPhone'];
    politicalStatus = json['politicalStatus'];
    originLocation = json['originLocation'];
    state = json['state'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['pinyin'] = this.pinyin;
    data['idCard'] = this.idCard;
    data['grade'] = this.grade;
    data['department'] = this.department;
    data['classes'] = this.classes;
    data['national'] = this.national;
    data['educationBackground'] = this.educationBackground;
    data['graduatedSchool'] = this.graduatedSchool;
    data['address'] = this.address;
    data['dormitory'] = this.dormitory;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['awards'] = this.awards;
    data['emergencyContact'] = this.emergencyContact;
    data['emergencyPhone'] = this.emergencyPhone;
    data['aid'] = this.aid;
    data['psychologicalLevel'] = this.psychologicalLevel;
    data['counsellorName'] = this.counsellorName;
    data['counsellorNum'] = this.counsellorNum;
    data['counsellorPhone'] = this.counsellorPhone;
    data['politicalStatus'] = this.politicalStatus;
    data['originLocation'] = this.originLocation;
    data['state'] = this.state;
    data['note'] = this.note;
    return data;
  }
}
