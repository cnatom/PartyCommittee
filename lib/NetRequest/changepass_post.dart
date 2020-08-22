import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/changepass_info.dart';
import '../NetClass/global.dart';

//获取登录json数据
changePassPost({String token,String oldpwd,String newpwd}) async {
  try{
    Map _jsonMap = {'oldpwd':oldpwd,'newpwd':newpwd};
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.post(
        "https://xyt-wx.cumt.edu.cn/api/stu-info/own/password",
        data: _jsonMap,
        options: Options(
          headers: {'Authorization':token}
        )
    );
    debugPrint(res.toString());
    //Json解码为Map
    Map<String,dynamic> map = jsonDecode(res.toString());
    Global.changePassInfo = ChangePassInfo.fromJson(map);

  }catch(e){
    print(e.toString());
  }

}
