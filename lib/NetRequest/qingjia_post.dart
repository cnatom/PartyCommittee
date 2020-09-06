import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:party_committee/UI_Widget/toast.dart';

//发送请假申请
Future<bool> qingjiaPost(BuildContext context, String token,
    {String startDate,
    String endDate,
    String reason,
    String emerPhone,
    String emerPeople,
    String myPhone,
    String destination}) async {
  try {
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.post("https://xyt-wx.cumt.edu.cn/api/leaves",
        data: {
          "startDate": startDate,
          "endDate": endDate,
          "reason": reason,
          "tel": myPhone,
          "emergencyCaller": emerPeople,
          "emergencyTel": emerPhone,
          "movement": destination
        },
        options: Options(headers: {'Authorization': token}));
    debugPrint(res.toString());
    //Json解码为Map
    Map<String, dynamic> map = jsonDecode(res.toString());
    if (map['code'] != 0) {
      showToast(context, map['message']);
      return false;
    } else {
      showToast(context, '提交成功！');
      return true;
    }
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
