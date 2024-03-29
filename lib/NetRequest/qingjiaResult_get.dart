import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/news_info.dart';
import 'package:party_committee/NetClass/qingjiaResultTea_info.dart';
import 'package:party_committee/NetClass/qingjiaResult_info.dart';
import 'package:party_committee/NetClass/swiper_info.dart';
import 'package:party_committee/UI_Widget/swiper.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import '../NetClass/global.dart';

//获取首页新闻json数据
qingjiaResultGet({String token}) async {
  try {
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.get("https://xyt-wx.cumt.edu.cn/api/leaves",
        options: Options(headers: {'Authorization': token}));
    debugPrint(res.toString());
    //Json解码为Map
    Map<String, dynamic> map = jsonDecode(res.toString());
    Global.qingjiaResultInfo = QingjiaResultInfo.fromJson(map);
  } catch (e) {
    print(e.toString());
  }
}

qingjiaResultTeaGet(
    BuildContext context,
    {@required int index,
    @required String token,
    @required String status,
    @required String current,
    String size = '20'}) async {
  try {
    Response res;
    Dio dio = Dio();
    res = await dio.get("https://xyt-wx.cumt.edu.cn/api/leaves/stu",
        queryParameters: {'status': status, 'current': current, 'size': size},
        options: Options(headers: {'Authorization': token}));
    debugPrint(res.toString());
    Map<String, dynamic> map = jsonDecode(res.toString());
    if(map['code']==0){
      Global.qingjiaresultTeaInfoList[index] = QingjiaResultTeaInfo.fromJson(map['data']);
    }else{
      showToast(context, map['message']);
    }

  } catch (e) {
    debugPrint(e.toString());
  }
}
