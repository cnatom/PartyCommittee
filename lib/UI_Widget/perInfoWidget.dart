//内容标题
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/UI_Widget/colors.dart';

TextStyle _itemTitleStyle =
    TextStyle(fontSize: fontSizeMini35, color: Color.fromARGB(255, 139, 143, 155));
TextStyle _itemContentStyle = TextStyle(fontSize: fontSizeMini35);
Icon _rightArrowIcon = Icon(
  Icons.chevron_right,
  color: Colors.black38,
);

//老师个人资料页顶端信息
Widget teacherInfoSliverAppBar(BuildContext context,
    {String photo = '',
      String name = '',
      String id = '',}) =>
    SliverAppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back_ios,size: fontSizeAppBar,),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "images/stu_background.png",
                fit: BoxFit.fill,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Opacity(
                  opacity: 0.1,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: ScreenUtil().setWidth(90),
              left: ScreenUtil().setWidth(90),
              child: Container(
                height: ScreenUtil().setWidth(180),
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: 'avatar',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          photo,
                          height: ScreenUtil().setWidth(180),
                          width: ScreenUtil().setWidth(180),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(50),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(50),
                                  color: Colors.white,
                                  letterSpacing: 2),
                            ),
                          ],
                        ),

                        Text(
                          "工号：$id ",
                          style: TextStyle(
                              fontSize: fontSizeNormal40,
                              color: Colors.white.withOpacity(0.7)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: pageBackgroundColor,
//        primary: true,
      expandedHeight: ScreenUtil().setWidth(450),
//        floating: true,
//        pinned: true,
//        snap: true,
    );
//学生个人资料页顶端信息
Widget stuInfoSliverAppBar(BuildContext context,
    {Widget image,
    String name='',
    String id='',
    String department='',
    String sex = '',
    String nation='',
    String grade='',
    String eduBackground=''}) {
  return SliverAppBar(
    leading: IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(Icons.arrow_back_ios,size: fontSizeAppBar,),
    ),
    flexibleSpace: FlexibleSpaceBar(
      background: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              "images/stu_background.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.black),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: ScreenUtil().setWidth(90),
            left: ScreenUtil().setWidth(90),
            child: Container(
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image,
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(50),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(50),
                                color: Colors.white,
                                letterSpacing: 2),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "( $id )",
                            style: TextStyle(
                                fontSize: fontSizeNormal40,
                                color: Colors.white.withOpacity(0.7)),
                          )
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setWidth(20),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            department,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: fontSizeMini35,
                                color: Colors.white,
                                letterSpacing: 2),
                          ),
                          Text(
                            "$sex  $nation  $grade级$eduBackground",
                            style: TextStyle(
                                fontSize: fontSizeMini35,
                                color: Colors.white,
                                letterSpacing: 2),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: pageBackgroundColor,
//        primary: true,
    expandedHeight: ScreenUtil().setWidth(450),
//        floating: true,
//        pinned: true,
//        snap: true,
  );
}

//个人资料子项(竖向)
Widget infoItem(String title, String content) {
  return Container(
    width: deviceWidth * 0.4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: _itemTitleStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          content,
          maxLines: 10,
          style: _itemContentStyle,
        ),
      ],
    ),
  );
}

//子项行排序
Widget infoRow({List<Widget> children = const <Widget>[]}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: children,
  );
}

//信息卡片
Widget infoCardArea(String title, {List data}) {
  //卡片标题
  Widget _cardTitle(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: fontSizeNormalTitle45, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  //卡片数据
  List<Widget> _infoList(List data) {
    return data.map((item) {
      var keys = item.keys.toList();
      var values = item.values.toList();
      return Column(
        children: <Widget>[
          infoRow(children: [
            infoItem(keys[0], values[0]),
            infoItem(keys[1], values[1]),
          ]),
          SizedBox(
            height: 20,
          ),
        ],
      );
    }).toList();
  }

  //卡片数据布局
  return Container(
    padding: EdgeInsets.fromLTRB(deviceWidth * 0.05, 0, 0, 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
    width: deviceWidth * 0.9,
    //信息列表
    child: Column(
      children: <Widget>[
        _cardTitle(title),
        Column(
          children: _infoList(data),
        )
      ],
    ),
  );
}

//高矩形卡片按钮
Widget recButton(
    String title, String imageResourceId, GestureTapCallback onTap) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, fontSizeMini35*1.3, 0, fontSizeMini35*1.3),
          width: fontSizeMini35*5.5,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                imageResourceId,
                width: fontSizeMini35*2.5,
              ),
              SizedBox(height: fontSizeMini35/1.5,),
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSizeMini35,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

//横向滚动列表
Widget rowRecButtonList(String title,
    {List<Widget> children = const <Widget>[]}) {
  return Column(
    children: <Widget>[
      Container(
        width: deviceWidth * 0.9,
        child: Text(
          title,
          style: _itemTitleStyle,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        width: deviceWidth * 0.92,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    ],
  );
}

//长条式卡片按钮(有内容)
Widget rowButtonWithContent(String title, String content,
    {GestureTapCallback onTap}) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: deviceWidth * 0.9,
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
                    style: _itemTitleStyle,
                  ),
                  Text(
                    content,
                    maxLines: 100,
                    style: _itemContentStyle,
                  )
                ],
              ),
            ),
            _rightArrowIcon
          ],
        ),
      ),
    ),
  );
}

//长条式卡片按钮(无内容)
Widget rowButtonWithoutContent(String title, {GestureTapCallback onTap}) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        width: deviceWidth * 0.9,
        //信息列表
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: fontSizeNormal40),
            ),
            _rightArrowIcon
          ],
        ),
      ),
    ),
  );
}
