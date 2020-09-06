class SearchStudentParentsInfo {
  int code;
  String message;
  Data data;

  SearchStudentParentsInfo({this.code, this.message, this.data});

  SearchStudentParentsInfo.fromJson(Map<String, dynamic> json) {
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
  String stuNum;
  String name1;
  String relation1;
  String pid1;
  String job1;
  String tel1;
  String addr1;
  String name2;
  String relation2;
  String pid2;
  String job2;
  String tel2;
  String addr2;

  Data(
      {this.stuNum,
        this.name1,
        this.relation1,
        this.pid1,
        this.job1,
        this.tel1,
        this.addr1,
        this.name2,
        this.relation2,
        this.pid2,
        this.job2,
        this.tel2,
        this.addr2});

  Data.fromJson(Map<String, dynamic> json) {
    stuNum = json['stuNum'];
    name1 = json['name1'];
    relation1 = json['relation1'];
    pid1 = json['pid1'];
    job1 = json['job1'];
    tel1 = json['tel1'];
    addr1 = json['addr1'];
    name2 = json['name2'];
    relation2 = json['relation2'];
    pid2 = json['pid2'];
    job2 = json['job2'];
    tel2 = json['tel2'];
    addr2 = json['addr2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stuNum'] = this.stuNum;
    data['name1'] = this.name1;
    data['relation1'] = this.relation1;
    data['pid1'] = this.pid1;
    data['job1'] = this.job1;
    data['tel1'] = this.tel1;
    data['addr1'] = this.addr1;
    data['name2'] = this.name2;
    data['relation2'] = this.relation2;
    data['pid2'] = this.pid2;
    data['job2'] = this.job2;
    data['tel2'] = this.tel2;
    data['addr2'] = this.addr2;
    return data;
  }
}
