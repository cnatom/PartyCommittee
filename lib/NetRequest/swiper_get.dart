import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/swiper_info.dart';
import 'package:party_committee/UI_Widget/swiper.dart';
import '../NetClass/global.dart';

//获取轮播图json数据
swiperGet() async {
  try{
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.get(
      "https://kddgw.wjy2000.cn/api/v1/carousel",
    );
    debugPrint(res.toString());
    //Json解码为Map
    Map<String,dynamic> map = jsonDecode(res.toString());
    Global.swiperInfo = SwiperInfo.fromJson(map);
  }catch(e){
    print(e.toString());
  }

}