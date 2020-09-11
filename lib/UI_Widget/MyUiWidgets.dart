import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:party_committee/DeviceData/device_data.dart';

import 'colors.dart';

//主页矩形按钮icon https://www.iconfont.cn/collections/detail?spm=a313x.7781069.1998910419.d9df05512&cid=19611
//diy页按钮icon https://www.iconfont.cn/collections/detail?spm=a313x.7781069.1998910419.d9df05512&cid=2089
//"我的"页icon https://www.iconfont.cn/collections/detail?spm=a313x.7781069.1998910419.d9df05512&cid=15640

//三个导航页的AppBar
PreferredSizeWidget MyMainAppBar(String title, {List<Widget> action}) => PreferredSize(
  preferredSize: Size.fromHeight(ScreenUtil().setSp(70)+ScreenUtil.statusBarHeight),
  child: AppBar(
    actions: action,
    brightness: Brightness.light,
    elevation: 0,
    flexibleSpace: Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(50), 0,0, ScreenUtil().setSp(15)),
      alignment: Alignment.bottomLeft,
      child: Text(
        title,
        style: TextStyle(
            letterSpacing: 2,
            fontSize: fontSizeMainAppBar,
            color: mainTextColor,
            fontWeight: FontWeight.bold),
      ),
    ),
    backgroundColor: pageBackgroundColor,
  ),
);

//白色背景AppBar
Widget MyAppBarWhite(BuildContext context, String title,
        {PreferredSizeWidget bottom,List<Widget> actions}) =>
    AppBar(
      actions: actions,
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
Widget MyAppBarColorful(BuildContext context, String title,
        {PreferredSizeWidget bottom,List<Widget> actions}) =>
    AppBar(
      actions: actions,
      bottom: bottom,
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
      margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: fontSizeNormalTitle45,
            width: ScreenUtil().setWidth(8),
            color: mainColor,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(30),
          ),
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                  color: mainTextColor,
                  fontSize: fontSizeNormalTitle45,
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
      width: deviceWidth / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.black.withAlpha(150),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
              onTap: onTap,
              child: Container(
                height: ScreenUtil().setWidth(140),
                width: ScreenUtil().setWidth(140),
                padding: EdgeInsets.all(ScreenUtil().setWidth(35)),
                child: Image.asset(iconResource),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
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
            style: TextStyle(fontSize: fontSizeMini35, color: mainTextColor),
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
    elevation: 1,
    shadowColor: shadowColor,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: deviceWidth * 0.42,
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  fontSize: fontSizeNormal40,
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
                fontSize: fontSizeMini35,
                color: mainTextColor.withAlpha(200),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.bottomEnd,
              child: Image.asset(
                resourceImageId,
                height: ScreenUtil().setWidth(100),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//设置页矩形按钮
Widget MyRecButton2(String text, String resourceImageId,
    {GestureTapCallback onTap, GestureLongPressCallback onLongPress}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    elevation: 1,
    shadowColor: shadowColor,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
        width: deviceWidth * 0.42,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(100),
              child: Image.asset(resourceImageId),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: fontSizeMini35,
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
          height: fontSizeNormal40*2.8,
          width: deviceWidth * 0.7,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  colors: [mainColor, mainColor.withAlpha(200)])),
          child: Text(
            title,
            style: TextStyle(letterSpacing: 1,color: Colors.white, fontSize: fontSizeNormal40),
          ),
        ),
      ),
    );
Widget MyFlatButtonWithoutGradient(String title,{double borderRadius = 30,GestureTapCallback onTap,Color color = Colors.blueAccent})=>Container(
  child: Material(
    borderRadius: BorderRadius.circular(borderRadius),
    color: color,
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: ScreenUtil().setWidth(100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(title,
            style: TextStyle(
                fontSize: fontSizeNormal40,
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.bold)),
      ),
    ),
  ),
);
//长条式卡片按钮(有内容)
//  TextStyle _itemTitleStyle =
//      TextStyle(fontSize: fontSizeNormal40, color: Color.fromARGB(255, 139, 143, 155));
//  TextStyle _itemContentStyle = TextStyle(fontSize: fontSizeNormal40);
Widget MyFullScreenButton(String title,{GestureTapCallback onTap})=>InkWell(
  splashColor: Colors.transparent,
  hoverColor: Colors.transparent,
  onTap: onTap,
  child: Container(
    alignment: Alignment.center,
    height: double.infinity,
    width: double.infinity,
    child: Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: fontSizeNormal40,color: Colors.black38),),
  ),
);
Widget MyRowFlexButtonWithContent(String title, String content,
    {GestureTapCallback onTap}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        //信息列表
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style:TextStyle(fontSize: fontSizeMini35, color: Color.fromARGB(255, 139, 143, 155)),
                  ),
                  SizedBox(height: fontSizeMini35/3,),
                  Text(
                    content,
                    maxLines: 100,
                    style: TextStyle(fontSize: fontSizeMini35),
                  )
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.black38,
              size: fontSizeMini35*2,
            )
          ],
        ),
      ),
    ),
  );
}
Future<String> MyInputDialogShow(BuildContext context,{String hintText = '请在此填写',VoidCallback onPressedYes,int maxLines = 1})async{
  TextEditingController controller;
  FocusNode focusNode = FocusNode();
  FocusScope.of(context).requestFocus(focusNode);
  String result;
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
        child: TextField(
          focusNode: focusNode,
          maxLines: maxLines,
          onChanged: (text){
            result = text;
          },
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: fontSizeNormal40,),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop(result);
          },
          child: Text('确定',style: TextStyle(fontSize: fontSizeNormal40),),
        ),
        FlatButton(
          onPressed: ()=>Navigator.of(context).pop(),
          child: Text('取消',style: TextStyle(fontSize: fontSizeNormal40)),
        ),
      ],
    ),
  );
}
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
            EdgeInsets.fromLTRB(ScreenUtil().setSp(50), 0, ScreenUtil().setSp(50), 0),
        height: ScreenUtil().setSp(200),
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
                    style: TextStyle(
                        fontSize: fontSizeNormal40,
                        color: mainTextColor),
                  ),
                ),
                Container(
                  child: Text(
                    time,
                    style: TextStyle(color: Colors.black45,fontSize: fontSizeMini35),
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
      padding: EdgeInsets.fromLTRB(fontSizeMini35*1.5, 0,0,0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: searchBarColor, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50))),
      child: TextField(
        controller: controller,
        style: TextStyle(color: mainTextColor,fontSize: fontSizeMini35),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: fontSizeMini35),
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
        padding: EdgeInsets.all(ScreenUtil().setWidth(70)),
        margin: EdgeInsets.all(ScreenUtil().setWidth(50)),
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
                      height: ScreenUtil().setWidth(160),
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
                        style: TextStyle(fontSize: fontSizeNormalTitle45, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "账号: " + id,
                        style: TextStyle(
                            fontSize: fontSizeNormal40, color: Colors.white.withAlpha(150)),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.chevron_right,
                        size: ScreenUtil().setWidth(70),
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
