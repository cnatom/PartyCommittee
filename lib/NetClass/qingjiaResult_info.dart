class QingjiaResultInfo {
  int code;
  String message;
  List<Data> data;

  QingjiaResultInfo({this.code, this.message, this.data});

  QingjiaResultInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String stuNum;
  String startDate;
  String endDate;
  String reason;
  int status;
  String tel;
  String emergencyCaller;
  String emergencyTel;
  String movement;
  String createTime;
  String reviewerId;

  Data(
      {this.id,
        this.stuNum,
        this.startDate,
        this.endDate,
        this.reason,
        this.status,
        this.tel,
        this.emergencyCaller,
        this.emergencyTel,
        this.movement,
        this.createTime,
        this.reviewerId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stuNum = json['stuNum'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    reason = json['reason'];
    status = json['status'];
    tel = json['tel'];
    emergencyCaller = json['emergencyCaller'];
    emergencyTel = json['emergencyTel'];
    movement = json['movement'];
    createTime = json['createTime'];
    reviewerId = json['reviewerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stuNum'] = this.stuNum;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['tel'] = this.tel;
    data['emergencyCaller'] = this.emergencyCaller;
    data['emergencyTel'] = this.emergencyTel;
    data['movement'] = this.movement;
    data['createTime'] = this.createTime;
    data['reviewerId'] = this.reviewerId;
    return data;
  }
}
