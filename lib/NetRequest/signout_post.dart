import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/login_info.dart';
import 'package:party_committee/NetClass/student_info.dart';
import 'package:party_committee/NetClass/teacher_info.dart';
import 'package:party_committee/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../NetClass/global.dart';

//退出登录
signOutPost(BuildContext context,String token) async {
  try{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();//清除存储的token
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.post(
        "http://49.233.32.252:9090/api/logins/out",
      options: Options(
        headers: {'Authorization':token}
      )
    );
    debugPrint(res.toString());
    //Json解码为Map
//    Map<String,dynamic> map = jsonDecode(res.toString());

    Global.studentInfo = new StudentInfo();
    Global.teacherInfo = new TeacherInfo();
  }catch(e){
    debugPrint(e.toString());
    toLoginPage(context);
  }

}
