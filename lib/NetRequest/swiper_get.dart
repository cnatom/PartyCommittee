

//获取轮播图json数据
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:party_committee/NetClass/swiper_info.dart';

import '../NetClass/global.dart';

swiperGet() async {
  try{
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.get(
//      "https://www.baidu.com/"
      "https://kddgw.wjy2000.cn/api/v1/carousel?format=json",
    );
    //Json解码为Map
    Map<String,dynamic> map = jsonDecode(res.toString());

    Global.swiperInfo = SwiperInfo.fromJson(map);
  }catch(e){
    print(e.toString());
  }

}