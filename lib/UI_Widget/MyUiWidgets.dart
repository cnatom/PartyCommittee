import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_committee/DeviceData/device_data.dart';

import 'colors.dart';

//主页矩形按钮icon https://www.iconfont.cn/collections/detail?spm=a313x.7781069.1998910419.d9df05512&cid=19611
//diy页按钮icon https://www.iconfont.cn/collections/detail?spm=a313x.7781069.1998910419.d9df05512&cid=2089
//"我的"页icon https://www.iconfont.cn/collections/detail?spm=a313x.7781069.1998910419.d9df05512&cid=15640

//三个导航页的AppBar
PreferredSizeWidget MyMainAppBar(String title, {List<Widget> action}) => AppBar(
      actions: action,
      brightness: Brightness.light,
      elevation: 0,
      leading: Container(),
      flexibleSpace: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
        alignment: Alignment.bottomLeft,
        height: 100,
        child: Text(
          title,
          style: TextStyle(
              letterSpacing: 2,
              fontSize: 25,
              color: mainTextColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: pageBackgroundColor,
    );

//白色背景AppBar
Widget MyAppBarWhite(BuildContext context, String title,
        {PreferredSizeWidget bottom}) =>
    AppBar(
      centerTitle: true,
      bottom: bottom,
      elevation: 0,
      brightness: Brightness.light,
      title: Text(
        title,
        style: TextStyle(
            color: mainTextColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSizeAppBar),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: mainTextColor,
          size: fontSizeAppBar,
        ),
        onPressed: () => Navigator.pop(context),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      backgroundColor: pageBackgroundColor,
    );

//主题色渐变AppBar
Widget MyAppBarColorful(BuildContext context, String title) => AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: fontSizeAppBar,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: fontSizeAppBar),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [mainColor, mainColor.withAlpha(200)])),
      ),
    );

//一般标题
Widget MyTitle(String title) => Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 18,
            width: 3,
            color: mainColor,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                  color: mainTextColor,
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );

//提示性文字
Widget tipText(String content) => Text(
      content,
      style: TextStyle(fontSize: 15, color: Colors.black38),
    );

//第一种按钮样式(圆形下方有标题)
Widget MyIconButton(String title, String iconResource,
        {Color backgroundColor = Colors.grey, GestureTapCallback onTap}) =>
    Container(
      width: deviceWidth/4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              highlightColor: Colors.black.withAlpha(150),
              borderRadius: BorderRadius.circular(20),
              onTap: onTap,
              child: Container(
                height: 55,
                width: 55,
                padding: EdgeInsets.all(14),
                child: Image.asset(iconResource),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          backgroundColor,
                          backgroundColor.withAlpha(150),
                        ])),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: mainTextColor),
          )
        ],
      ),
    );

//矩形按钮
Widget MyRecButton1(String text, String subText, String resourceImageId,
    {GestureTapCallback onTap}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    elevation: 5,
    shadowColor: shadowColor,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: deviceWidth*0.42,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  color: mainTextColor,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              subText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: mainTextColor.withAlpha(200),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.bottomEnd,
              height: 40,
              child: Image.asset(resourceImageId,height: 40,),
            ),
          ],
        ),
      ),
    ),
  );
}

//设置页矩形按钮
Widget MyRecButton2(String text, String resourceImageId,
    {GestureTapCallback onTap,GestureLongPressCallback onLongPress}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    elevation: 2,
    shadowColor: shadowColor,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.all(20),
        width: deviceWidth*0.42,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              child: Image.asset(resourceImageId),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  color: mainTextColor,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ),
  );
}

//长条式按钮
Widget MyFlatButton(String title, {GestureTapCallback onTap}) => Material(
      borderRadius: BorderRadius.circular(50),
      elevation: 5,
      shadowColor: shadowColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Container(
          height: 50,
          width: deviceWidth * 0.8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  colors: [mainColor, mainColor.withAlpha(200)])),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );

//新闻列表单项
Widget MyNewsItemButton(
    {String title = "内容获取失败", String time = "null", GestureTapCallback onTap}) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: iconBackColor, width: 0.5)),
        padding:
            EdgeInsets.fromLTRB(deviceWidth * 0.05, 0, deviceWidth * 0.05, 0),
        height: 90,
        width: deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: deviceWidth * 0.85,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize:15,fontWeight: FontWeight.bold, color: mainTextColor),
                  ),
                ),
                Container(
                  child: Text(
                    time,
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

//搜索条
Widget MySearchBar(TextEditingController controller,
        {IconData preIcon = Icons.search, String hintText = ''}) =>
    Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
          color: searchBarColor, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: mainTextColor),
        decoration: InputDecoration(
            prefixIcon: Icon(preIcon),
            border: InputBorder.none,
            hintText: hintText),
      ),
    );



//个人资料卡
Widget MyselfCard(
        {String imageResource,
        String name,
        String id,
        GestureTapCallback onTap}) =>
    Material(
      color: pageBackgroundColor,
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  mainColor,
                  mainColor.withAlpha(180),
                ])),
        child: Wrap(
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: onTap,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      imageResource,
                      height: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "账号: " + id,
                        style: TextStyle(
                            fontSize: 16, color: Colors.white.withAlpha(150)),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.chevron_right,
                        size: 30,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  )
                ],
              ),
            ),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Expanded(
//              flex: 1,
//              child: Container(
//                alignment: Alignment.center,
//                child: Wrap(
//                  spacing: 5,
//                  crossAxisAlignment: WrapCrossAlignment.center,
//                  direction: Axis.vertical,
//                  children: <Widget>[
//                    Text("¥ 100.0",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
//                    Text("校园卡余额",style: TextStyle(color: Colors.white,fontSize: 16),),
//                  ],
//                ),
//              ),
//            ),
//            Container(
//              color: Colors.white.withAlpha(100),
//              height: 50,
//              width: 1,
//            ),
//            Expanded(
//              flex: 1,
//              child: Container(
//                alignment: Alignment.center,
//                child: Wrap(
//                  spacing: 5,
//                  crossAxisAlignment: WrapCrossAlignment.center,
//                  direction: Axis.vertical,
//                  children: <Widget>[
//                    Text("50W",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
//                    Text("宿舍电量",style: TextStyle(color: Colors.white,fontSize: 16),),
//                  ],
//                ),
//              ),
//            ),
//          ],
//        )
          ],
        ),
      ),
    );
