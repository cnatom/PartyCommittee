//第三个功能页

//import 'dart:html';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:package_info/package_info.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/app_upgrade.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/buttons.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/containers.dart';
import 'package:party_committee/pages/childPages/diy_page_child/bangong_page.dart';
import 'package:party_committee/pages/childPages/diy_page_child/chengji_page.dart';
import 'package:party_committee/pages/childPages/diy_page_child/qingjia_stu_page.dart';
import 'package:party_committee/pages/childPages/diy_page_child/qingjia_tea_page.dart';
import 'package:party_committee/pages/childPages/diy_page_child/xiaoche_page.dart';
import 'package:party_committee/pages/childPages/diy_page_child/xiaoli_page.dart';
import 'package:party_committee/pages/null_page.dart';
import 'package:party_committee/pages/test.dart';

import 'diy_page_child/ruxiao_page.dart';
import 'diy_page_child/xueshengSearchChild_page.dart';
import 'diy_page_child/xueshengSearch_page.dart';

class DiyPage extends StatefulWidget {
  @override
  _DiyPageState createState() => _DiyPageState();
}

//主页面
class _DiyPageState extends State<DiyPage> with AutomaticKeepAliveClientMixin{




  //初始化按钮列表
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: MyMainAppBar("功能"),
      body:  SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Wrap(
              runSpacing: 25,
              runAlignment: WrapAlignment.center,
              children: <Widget>[
                Container(height: 1,),
                MyTitle("通用服务"),
                MyIconButton("办公黄页", 'images/bangong.png',backgroundColor: iconButtonColor[0],onTap: ()=>toBangongPage(context)),
                MyIconButton("校车", 'images/xiaoche.png',backgroundColor: iconButtonColor[1],onTap: ()=>toXiaochePage(context)),
                MyIconButton("校历", 'images/xiaoli.png',backgroundColor: iconButtonColor[2],onTap: ()=>toXiaoliPage(context)),
                MyIconButton("请假", 'images/qingjia.png',backgroundColor: iconButtonColor[3],onTap: ()=>Global.admin==0?toQingjiaStuPage(context):toQingjiaTeaPage(context)),
                MyTitle("学生服务"),
                MyIconButton("入校申请", 'images/ruxiao.png',backgroundColor: iconButtonColor[3],onTap: ()=>toRuxiaoPage(context)),
                MyIconButton("成绩查询", 'images/chengji.png',backgroundColor: iconButtonColor[1],onTap: ()=>toChengjiPage(context)),
                MyIconButton("销假", 'images/xiaojia.png',backgroundColor: iconButtonColor[0],onTap: ()=>toNullPage(context)),
                MyIconButton("课表", 'images/kebiao.png',backgroundColor: iconButtonColor[2],onTap: ()=>toNullPage(context)),
                MyIconButton("场地预约", 'images/changdi.png',backgroundColor: iconButtonColor[0],onTap: ()=>toNullPage(context)),
                MyIconButton("职业规划", 'images/zhiye.png',backgroundColor: iconButtonColor[2],onTap: ()=>toNullPage(context)),
                MyIconButton("资助查询", 'images/zizhu.png',backgroundColor: iconButtonColor[1],onTap: ()=>toNullPage(context)),
                MyIconButton("心理咨询", 'images/xinli.png',backgroundColor: iconButtonColor[3],onTap: ()=>toNullPage(context)),
                MyIconButton("班级通讯", 'images/banji.png',backgroundColor: iconButtonColor[1],onTap: ()=>toNullPage(context)),
                MyTitle("教师服务"),
                MyIconButton("学生查询", 'images/xuesheng.png',backgroundColor: iconButtonColor[1],onTap: ()=>toXueshengPage(context)),
                MyIconButton("党工委", 'images/danggong.png',backgroundColor: iconButtonColor[0],onTap: ()=>toNullPage(context)),
                Container(),
              ],
            ),
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
