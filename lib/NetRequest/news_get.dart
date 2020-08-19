import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/news_info.dart';
import 'package:party_committee/NetClass/swiper_info.dart';
import 'package:party_committee/UI_Widget/swiper.dart';
import '../NetClass/global.dart';

//获取首页新闻json数据
newsGet() async {
  try{
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.get(
      "https://kddgw.wjy2000.cn/api/v1/news?is_full_content=True",
    );
    debugPrint(res.toString());
    //Json解码为Map
    Map<String,dynamic> map = jsonDecode(res.toString());
    Global.newsInfo = NewsInfo.fromJson(map);

  }catch(e){
    print(e.toString());
  }

}
