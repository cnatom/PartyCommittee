import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_committee/UI_Widget/colors.dart';

//用来放图标的列表
Widget gridContainer({List<Widget> children,}){
  return Container(
    child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: 0,
      //垂直子Widget之间间距
      mainAxisSpacing: 20,
      shrinkWrap: true,
      //GridView内边距
      padding: EdgeInsets.all(20.0),
      //一行的Widget数量
      crossAxisCount: 4,
      //子Widget宽高比例
      //子Widget列表
      children: children,
    ),
  );
}


//圆角无阴影容器
Widget Cir_container(
    {Widget child,
    EdgeInsetsGeometry padding,
    Color color = Colors.white,
    double radius = 100,
    double blurRadius = 2,
    double spreadRadius = 0.02}) {
  return Container(
    padding: padding, //内容与边框的间距
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius), //圆角拉满
      color: color, //默认为半透明白底色
      boxShadow: [
        BoxShadow(
            blurRadius: blurRadius, //阴影范围
            spreadRadius: spreadRadius, //阴影浓度
            color: Colors.black12, //阴影颜色
            offset: Offset(0.0, 2)),
      ],
    ),
    child: child,
  );
}
