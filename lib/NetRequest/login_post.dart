import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/login_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NetClass/global.dart';

//获取登录json数据
Future<bool> loginPost({String username, String password}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    Map _jsonMap = {'username': username, 'password': password};
    String uri = '';

    if(username.length>=8){
      uri = "https://xyt-wx.cumt.edu.cn/api/logins/student";
      Global.admin = 0;
    }else{
      uri = "https://xyt-wx.cumt.edu.cn/api/logins/admin";
      Global.admin = 1;
    }
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.post(uri, data: _jsonMap);
    debugPrint(res.toString());
    //Json解码为Map
    Map<String, dynamic> map = jsonDecode(res.toString());
    Global.loginInfo = LoginInfo.fromJson(map);
    if (Global.loginInfo.code == 0) {
      //登录成功
      prefs.setString('token', Global.loginInfo.data.token.toString());
      prefs.setString('username', username);
      prefs.setString('password', password);
      Global.id = username;
      return true;
    }else{
      return false;
    }
  } catch (e) {

    print('@@@@@@@@@' + e.toString());
    return false;
  }
}
