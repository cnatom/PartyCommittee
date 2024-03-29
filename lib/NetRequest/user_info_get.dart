import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/student_info.dart';
import 'package:party_committee/NetClass/teacher_info.dart';
import '../NetClass/global.dart';

//获取学生信息json数据
userInfoGet(
  String token,
) async {
  try {
    Response res;
    Dio dio = Dio();
    String uri = Global.admin == 0
        ? "https://xyt-wx.cumt.edu.cn/api/stu-info/me"
        : "https://xyt-wx.cumt.edu.cn/api/core-admin/get/own";
    //配置dio信息
    res = await dio.get(
      uri,
      options: Options(headers: {'Authorization': token}),
    );
    debugPrint(res.toString());
    //Json解码为Map
    Map<String, dynamic> map = jsonDecode(res.toString());
    //根据权限决定数据分配实例
    if(Global.admin == 0){
      Global.studentInfo = StudentInfo.fromJson(map);
    }else{
      Global.teacherInfo = TeacherInfo.fromJson(map);
    }
  } catch (e) {
    print(e.toString());
  }
}
