class QingjiaResultTeaInfo {
  int code;
  String message;
  Data data;

  QingjiaResultTeaInfo({this.code, this.message, this.data});

  QingjiaResultTeaInfo.fromJson(Map<String, dynamic> json) {
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
  List<Records> records;
  String total;
  String size;
  String current;
  bool optimizeCountSql;
  bool hitCount;
  bool searchCount;
  String pages;

  Data(
      {this.records,
        this.total,
        this.size,
        this.current,
        this.optimizeCountSql,
        this.hitCount,
        this.searchCount,
        this.pages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = new List<Records>();
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    optimizeCountSql = json['optimizeCountSql'];
    hitCount = json['hitCount'];
    searchCount = json['searchCount'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['size'] = this.size;
    data['current'] = this.current;
    data['optimizeCountSql'] = this.optimizeCountSql;
    data['hitCount'] = this.hitCount;
    data['searchCount'] = this.searchCount;
    data['pages'] = this.pages;
    return data;
  }
}

class Records {
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
  String name;
  String department;
  String classes;

  Records(
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
        this.reviewerId,
        this.name,
        this.department,
        this.classes});

  Records.fromJson(Map<String, dynamic> json) {
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
    name = json['name'];
    department = json['department'];
    classes = json['classes'];
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
    data['name'] = this.name;
    data['department'] = this.department;
    data['classes'] = this.classes;
    return data;
  }
}
