class ChengjiInfo {
  int code;
  String msg;
  List<Data> data;

  ChengjiInfo({this.code, this.msg, this.data});

  ChengjiInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
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
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String kcmc;
  int bfzcj;
  String jd;
  String xf;
  String cjzc;
  String xm;
  String xh;
  String njdmId;
  String jgmc;
  String zymc;
  String xnm;
  String xqm;

  Data(
      {this.kcmc,
        this.bfzcj,
        this.jd,
        this.xf,
        this.cjzc,
        this.xm,
        this.xh,
        this.njdmId,
        this.jgmc,
        this.zymc,
        this.xnm,
        this.xqm});

  Data.fromJson(Map<String, dynamic> json) {
    kcmc = json['kcmc'];
    bfzcj = json['bfzcj'];
    jd = json['jd'];
    xf = json['xf'];
    cjzc = json['cjzc'];
    xm = json['xm'];
    xh = json['xh'];
    njdmId = json['njdm_id'];
    jgmc = json['jgmc'];
    zymc = json['zymc'];
    xnm = json['xnm'];
    xqm = json['xqm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kcmc'] = this.kcmc;
    data['bfzcj'] = this.bfzcj;
    data['jd'] = this.jd;
    data['xf'] = this.xf;
    data['cjzc'] = this.cjzc;
    data['xm'] = this.xm;
    data['xh'] = this.xh;
    data['njdm_id'] = this.njdmId;
    data['jgmc'] = this.jgmc;
    data['zymc'] = this.zymc;
    data['xnm'] = this.xnm;
    data['xqm'] = this.xqm;
    return data;
  }
}
