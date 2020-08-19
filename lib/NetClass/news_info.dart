class NewsInfo {
  int code;
  String msg;
  Data data;

  NewsInfo({this.code, this.msg, this.data});

  NewsInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Headline headline;
  List<NewsList> newsList;

  Data({this.headline, this.newsList});

  Data.fromJson(Map<String, dynamic> json) {
    headline = json['headline'] != null
        ? new Headline.fromJson(json['headline'])
        : null;
    if (json['news_list'] != null) {
      newsList = new List<NewsList>();
      json['news_list'].forEach((v) {
        newsList.add(new NewsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.headline != null) {
      data['headline'] = this.headline.toJson();
    }
    if (this.newsList != null) {
      data['news_list'] = this.newsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Headline {
  String url;
  String imgUrl;
  String title;
  String summary;

  Headline({this.url, this.imgUrl, this.title, this.summary});

  Headline.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    imgUrl = json['img_url'];
    title = json['title'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['img_url'] = this.imgUrl;
    data['title'] = this.title;
    data['summary'] = this.summary;
    return data;
  }
}

class NewsList {
  String title;
  String url;
  String time;
  String detailUrl;
  List<String> paragraphs;

  NewsList({this.title, this.url, this.time, this.detailUrl, this.paragraphs});

  NewsList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    time = json['time'];
    detailUrl = json['detail_url'];
    paragraphs = json['paragraphs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['time'] = this.time;
    data['detail_url'] = this.detailUrl;
    data['paragraphs'] = this.paragraphs;
    return data;
  }
}
