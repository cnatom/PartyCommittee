
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//圆角阴影容器
Widget Box_container({Widget child}){
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      border: new Border.all(
        color: Colors.grey, //边框颜色
        width: 0.1, //边框宽度
      ), // 边色与边宽度
      color: Colors.white, // 底色
      boxShadow: [
        BoxShadow(
            blurRadius: 2, //阴影范围
            spreadRadius: 0.01, //阴影浓度
            color: Colors.black12, //阴影颜色
            offset: Offset(0.0,2)
        ),
      ],
      borderRadius: BorderRadius.circular(20),
    ),
    child: child,
  );
}