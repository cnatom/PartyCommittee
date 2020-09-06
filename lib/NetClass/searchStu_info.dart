class SearchStuInfo {
  int code;
  String message;
  Data data;

  SearchStuInfo({this.code, this.message, this.data});

  SearchStuInfo.fromJson(Map<String, dynamic> json) {
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
  String name;
  String department;
  String grade;
  String classes;

  Records({this.id, this.name, this.department, this.grade, this.classes});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    department = json['department'];
    grade = json['grade'];
    classes = json['classes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['department'] = this.department;
    data['grade'] = this.grade;
    data['classes'] = this.classes;
    return data;
  }
}
