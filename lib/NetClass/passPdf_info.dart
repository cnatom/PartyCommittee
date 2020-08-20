class PassPdfInfo {
  int code;
  String message;
  Data data;

  PassPdfInfo({this.code, this.message, this.data});

  PassPdfInfo.fromJson(Map<String, dynamic> json) {
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
  String stuId;
  String name;
  String date;
  String loc;
  String reviewedBy;
  String emergencyCallee;

  Data(
      {this.stuId,
        this.name,
        this.date,
        this.loc,
        this.reviewedBy,
        this.emergencyCallee});

  Data.fromJson(Map<String, dynamic> json) {
    stuId = json['stuId'];
    name = json['name'];
    date = json['date'];
    loc = json['loc'];
    reviewedBy = json['reviewedBy'];
    emergencyCallee = json['emergencyCallee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stuId'] = this.stuId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['loc'] = this.loc;
    data['reviewedBy'] = this.reviewedBy;
    data['emergencyCallee'] = this.emergencyCallee;
    return data;
  }
}
