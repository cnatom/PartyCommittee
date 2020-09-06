import 'dart:ui';

import 'package:flui/flui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'colors.dart';


Widget roundButton = Container(
  height: 80,
  child: RaisedButton(
      child: Text('圆形按钮'),
      color: Colors.white,
      textColor: Colors.white,
//      elevation: 20,
      shape: CircleBorder(side: BorderSide(color: Colors.white)),
      onPressed: () {
        print("圆形按钮");
      }),
);

//小按钮
Widget greyFlatButton(String text, {VoidCallback onPressed,double fontSize}) => FlatButton(
  onPressed: onPressed,
  highlightColor: Colors.transparent, //点击后的颜色为透明
  splashColor: Colors.transparent, //点击波纹的颜色为透明
  child: Text(
    text,
    style: TextStyle(
        color: Colors.black38, //字体颜色
        fontSize: fontSizeMini35),
  ),
);

//功能页函数按钮(下方带文字)
Widget funcPageButton(
    {String title = '', //下方的文本
    String imageResourceId = 'images/null.png', //资源位置
    Color backgroundColor = Colors.transparent, //背景颜色
    GestureTapCallback onTap, //点击后的事件
    Color textColor = Colors.black, //文字颜色
    double elevation = 0 //阴影大小
    }) {
  return Container(
    height: 110,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Material(
          shadowColor: Colors.black38,
          elevation: elevation,
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(15),
              width: deviceWidth / 7,
              child: Image.asset(imageResourceId),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: textColor),
        )
      ],
    ),
  );
}

//主页矩形功能按钮
Widget rectangleButton(String text, String subText, String resourceImageId,
    {GestureTapCallback onTap, double elevation = 0}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    elevation: elevation,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(deviceWidth / 2.3 * 0.657 * 0.08),
        width: deviceWidth / 2.3,
        height: deviceWidth / 2.3 * 0.657,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style:
                  TextStyle(fontSize: 16, color: mainColor, letterSpacing: 3,fontWeight: FontWeight.w600),
            ),
            Text(
              subText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: mainColor,
                  height: deviceWidth / 2.3 * 0.657 * 0.011),
            ),
            Container(
              height: deviceWidth / 2.3 * 0.657 * 0.38,
              alignment: AlignmentDirectional.bottomEnd,
              child: Image.asset(resourceImageId),
            )
          ],
        ),
      ),
    ),
  );
}


//ListView自定义子项
Widget listItemButton({GestureTapCallback onTap,String title}){
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38,width: 0.05)
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title,style: TextStyle(fontSize: 16),),
            Icon(Icons.chevron_right,color: Colors.black38,)
          ],
        ),

      ),
    ),
  );
}