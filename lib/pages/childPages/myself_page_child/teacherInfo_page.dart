import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/user_info_get.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/perInfoWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

//跳转到当前页面
void toTeacherInfoPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => TeacherInfoPage()));
}

class TeacherInfoPage extends StatefulWidget {
  @override
  _TeacherInfoPageState createState() => _TeacherInfoPageState();
}

class _TeacherInfoPageState extends State<TeacherInfoPage> {
  Future<Null> _loadingUserInfo() async {
    if (Global.studentInfo.data == null || Global.teacherInfo.data == null) {
      final token = (await SharedPreferences.getInstance()).getString('token');
      await userInfoGet(token);
      setState(() {

      });
    }
  }
  @override
  void initState() {
    super.initState();
    _loadingUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Global.teacherInfo.data == null
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: mainColor,
                    size: 18,
                  ),
                ),
              )
            : null,
        backgroundColor: pageBackgroundColor,
        body: Global.teacherInfo.data == null
            ? Center(
                child: loadingAnimationWave,
              )
            : CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  teacherInfoSliverAppBar(
                    context,
                    photo: "images/test.png",
                    name: Global.teacherInfo.data.name,
                    id: Global.teacherInfo.data.id,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          infoCardArea("基本信息", data: [
                            {
                              "性别": Global.teacherInfo.data.gender,
                              "所在年级": Global.teacherInfo.data.work
                            },
                            {
                              "职业": Global.teacherInfo.data.occupation,
                              "所在部门": Global.teacherInfo.data.department,
                            },
                            {"座机号码": Global.teacherInfo.data.tel, "": ""},
                          ]),
                        ],
                      )
                    ]),
                  )
                ],
              ));
  }
}
