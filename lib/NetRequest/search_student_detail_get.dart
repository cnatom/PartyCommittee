


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/searchStudentParents_info.dart';
import 'package:party_committee/NetClass/searchStudent_info.dart';
import 'package:party_committee/NetClass/student_info.dart';

searchStuDetailGet({String id,String token}) async {
  try{
    Response resStu,resPar;
    Dio dio = Dio();
    //配置dio信息
    resStu = await dio.get(
        "https://xyt-wx.cumt.edu.cn/api/stu-info/get/"+id,
        options: Options(headers: {'Authorization':token})
    );
//    resPar = await dio.get(
//        "https://xyt-wx.cumt.edu.cn/api/stu-info/parents/"+id,
//        options: Options(headers: {'Authorization':token})
//    );
    debugPrint(resStu.toString());
//    debugPrint(resPar.toString());

    //Json解码为Map
    Map<String,dynamic> mapStu = jsonDecode(resStu.toString());
//    Map<String,dynamic> mapPar = jsonDecode(resPar.toString());

    Global.searchStudentInfo = SearchStudentInfo.fromJson(mapStu);
//    Global.searchStudentParentsInfo = SearchStudentParentsInfo.fromJson(mapPar);
  }catch(e){
    print(e.toString());
  }

}