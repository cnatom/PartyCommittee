import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
//色彩管理
final Color mainColor =  Color.fromARGB(255, 39,133,255).withAlpha(255);
final Color mainTextColor = Color.fromARGB(255, 12,21,60);
final Color shadowColor = Colors.black45;
final Color searchBarColor = Color.fromARGB(255, 241,241,241);
final double fontSize15 = ScreenUtil().setSp(15);
final double fontSizeMainAppBar = ScreenUtil().setSp(60);
final double fontSizeAppBar = ScreenUtil().setSp(45);
final double fontSizeNormalTitle45 = ScreenUtil().setSp(45);
final double fontSizeMini35 = ScreenUtil().setSp(35);
final double fontSizeNormal40 = ScreenUtil().setSp(40);
final List iconButtonColor = [
  Color.fromARGB(255, 255,81,29),
  Color.fromARGB(255, 39,133,255),
  Color.fromARGB(255, 251,48,60),
  Color.fromARGB(255, 26,188,156),
];

//Color mainColor = Color.fromARGB(255, 54,189,251).withAlpha(255);
//final Color mainColor = Color.fromARGB(255, 61,134,228).withAlpha(255);
//final Color mainColor = Colors.pinkAccent;
final Color pageBackgroundColor = Color.fromARGB(255, 243,245,248);
final Color textColor = Colors.white;  //主文本色彩
final Color transWhite = Color.fromARGB(150, 255, 255, 255);  //半透明白色
final Color iconBackColor = Color.fromARGB(255, 239,239,241); //功能页图标的背景颜色
final Color appBarColor = Color.fromARGB(255, 237,237,237);//顶部AppBar的背景颜色
final Color unselectedColor = Color.fromARGB(255, 170,170,181);//未选中选项的颜色