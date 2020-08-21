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
void toStudentInfoPage(BuildContext context) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => StudentInfoPage()));
}

class StudentInfoPage extends StatefulWidget {
  @override
  _StudentInfoPageState createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {



  @override
  void initState() {
    super.initState();
    build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Global.studentInfo.data==null?AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: ()=>Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios,color: mainColor,size: 18,),
        ),
      ):null,
      backgroundColor: pageBackgroundColor,
      body: Global.studentInfo.data==null
          ?Center(child: loadingAnimation,)
          :CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          stuInfoSliverAppBar(
            context,
            photo: 'images/test.png',
            name: Global.studentInfo.data.name,
            id: Global.studentInfo.data.id,
            department: Global.studentInfo.data.department,
            sex: Global.studentInfo.data.gender,
            nation: Global.studentInfo.data.national,
            grade: Global.studentInfo.data.grade,
            eduBackground: Global.studentInfo.data.educationBackground
          ),

          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  infoCardArea("基本信息",data: [
                    {"电话": Global.studentInfo.data.phone, "邮箱": Global.studentInfo.data.email},
                    {'身份证': Global.studentInfo.data.idCard, "姓名拼音": Global.studentInfo.data.pinyin},
                    {'毕业学校': Global.studentInfo.data.graduatedSchool, "政治面貌": Global.studentInfo.data.politicalStatus},
                    {"生源地": Global.studentInfo.data.originLocation, '家庭住址': Global.studentInfo.data.address},
                  ]),
                  SizedBox(height: 20,),
                  infoCardArea("在校信息",data: [
                    {"班级": Global.studentInfo.data.classes, "寝室": Global.studentInfo.data.dormitory},
                    {"辅导员": Global.studentInfo.data.counsellorName,"紧急联系人": Global.studentInfo.data.emergencyContact},
                    {'辅导员电话':Global.studentInfo.data.counsellorPhone,"紧急联系人电话": Global.studentInfo.data.emergencyPhone},
                  ]),
                  SizedBox(height: 20,),
                  rowButtonWithContent("经济援助", Global.studentInfo.data.aid,onTap: (){}),
                  SizedBox(height: 20,),
                  rowButtonWithContent("获奖情况",Global.studentInfo.data.awards,onTap: (){}),
                  SizedBox(height: 100,),

                ],
              )
            ]),
          )
        ],
      )
    );
  }
}
