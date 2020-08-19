
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/animationEffect/custome_router.dart';

//跳转到当前页面
void toTestMyselfPage(BuildContext context) {
  Navigator.of(context).push(CustomRoute(TestMyselfPage(),milliseconds: 500));
}

class TestMyselfPage extends StatefulWidget {
  @override
  _TestMyselfPageState createState() => _TestMyselfPageState();
}

class _TestMyselfPageState extends State<TestMyselfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyMainAppBar("我的"),
      body: Wrap(
        runSpacing: 10,
        alignment: WrapAlignment.spaceAround,
        children: <Widget>[
          MyselfCard(imageResource: 'images/test.jpg',name: "牟金腾",id: '08192988'),
          MyTitle("设置"),
          Wrap(
            spacing: deviceWidth*0.03,
            runSpacing: 20,
            children: <Widget>[
              MyRecButton2("修改密码",  'images/xiugai.png',onTap: (){}),
              MyRecButton2("问题反馈", 'images/fankui.png',onTap: (){}),
              MyRecButton2("关于",  'images/guanyu.png',onTap: (){}),
            ],
          )
        ],
      ),
    );
  }
}
