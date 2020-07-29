class SwiperInfo {
  int code;
  List<Data> data;
  String msg;

  SwiperInfo({this.code, this.data, this.msg});

  SwiperInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  String title;
  String imgUrl;
  String targetUrl;

  Data({this.title, this.imgUrl, this.targetUrl});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imgUrl = json['img_url'];
    targetUrl = json['target_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['img_url'] = this.imgUrl;
    data['target_url'] = this.targetUrl;
    return data;
  }
}
