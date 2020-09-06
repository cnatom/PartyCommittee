


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/searchStu_info.dart';

searchStuGet({String aim,int curPageNum,String token,int pageSize=20}) async {
  try{
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.get(
      "https://xyt-wx.cumt.edu.cn/api/stu-info/page",
      queryParameters: {'param':aim,'current':curPageNum.toString(),'size':pageSize},
      options: Options(headers: {'Authorization':token})
    );
    debugPrint(res.toString());
    //Json解码为Map
    Map<String,dynamic> map = jsonDecode(res.toString());
    Global.searchStuInfo = SearchStuInfo.fromJson(map);
  }catch(e){
    print(e.toString());
  }

}