import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/searchStudent_info.dart';
import 'package:party_committee/NetClass/student_info.dart';
import 'package:party_committee/NetRequest/search_student_detail_get.dart';
import 'package:party_committee/NetRequest/user_info_get.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/perInfoWidget.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//跳转到当前页面
void toXueshengChildPage(BuildContext context,String id) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => XueshengChildPage(id)));
}

class XueshengChildPage extends StatefulWidget {
  String id;
  XueshengChildPage(this.id);//接收学生学号信息
  @override
  _XueshengChildPageState createState() => _XueshengChildPageState();
}

class _XueshengChildPageState extends State<XueshengChildPage> {
  String photoSrc;
  //加载页面数据
  void _loadStuInfo()async{
    if(Global.searchStudentInfo.data==null){
      photoSrc = "https://xyt-wx.cumt.edu.cn/api/documents/"+widget.id+'?token='+Global.token;
      await searchStuDetailGet(token: Global.token,id: widget.id);
      if(Global.searchStudentInfo.code!=0){
        showToast(context, Global.searchStudentInfo.message);
      }else{
        setState(() {
        });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _loadStuInfo();
  }

  @override
  void dispose() {
    super.dispose();
    Global.searchStudentInfo = new SearchStudentInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Global.searchStudentInfo.data==null?loadingPage(context):Scaffold(
        backgroundColor: pageBackgroundColor,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            stuInfoSliverAppBar(
                context,
                image: Image.network(
                  photoSrc,
                  alignment: Alignment.topCenter,
                  width: ScreenUtil().setWidth(180),
                  height: ScreenUtil().setWidth(200),
                  fit: BoxFit.fitWidth,
                ),
                name: Global.searchStudentInfo.data.name,
                id: Global.searchStudentInfo.data.id,
                department: Global.searchStudentInfo.data.department,
                sex: Global.searchStudentInfo.data.gender,
                nation: Global.searchStudentInfo.data.national,
                grade: Global.searchStudentInfo.data.grade,
                eduBackground: Global.searchStudentInfo.data.educationBackground
            ),

            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    infoCardArea("基本信息",data: [
                      {"电话": Global.searchStudentInfo.data.phone, "邮箱": Global.searchStudentInfo.data.email},
                      {'身份证': Global.searchStudentInfo.data.idCard, "姓名拼音": Global.searchStudentInfo.data.pinyin},
                      {'毕业学校': Global.searchStudentInfo.data.graduatedSchool, "政治面貌": Global.searchStudentInfo.data.politicalStatus},
                      {"生源地": Global.searchStudentInfo.data.originLocation, '家庭住址': Global.searchStudentInfo.data.address},
                    ]),
                    SizedBox(height: 20,),
                    infoCardArea("在校信息",data: [
                      {"班级": Global.searchStudentInfo.data.classes, "寝室": Global.searchStudentInfo.data.dormitory},
                      {"辅导员": Global.searchStudentInfo.data.counsellorName,"紧急联系人": Global.searchStudentInfo.data.emergencyContact},
                      {'辅导员电话':Global.searchStudentInfo.data.counsellorPhone.toString(),"紧急联系人电话": Global.searchStudentInfo.data.emergencyPhone},
                    ]),
                    infoCardArea("父母信息",data: [
                      {"班级": Global.searchStudentInfo.data.classes, "寝室": Global.searchStudentInfo.data.dormitory},
                      {"辅导员": Global.searchStudentInfo.data.counsellorName,"紧急联系人": Global.searchStudentInfo.data.emergencyContact},
                      {'辅导员电话':Global.searchStudentInfo.data.counsellorPhone.toString(),"紧急联系人电话": Global.searchStudentInfo.data.emergencyPhone},
                    ]),
                    SizedBox(height: 20,),
                    rowButtonWithoutContent("学生成绩",onTap: (){showToast(context, '施工中……');}),
                    SizedBox(height: 20,),
                    rowButtonWithContent("心理等级", Global.searchStudentInfo.data.psychologicalLevel.toString()),
                    SizedBox(height: 20,),
                    rowButtonWithContent("经济援助", Global.searchStudentInfo.data.aid.toString(),onTap: (){}),
                    SizedBox(height: 20,),
                    rowButtonWithContent("获奖情况", Global.searchStudentInfo.data.awards.toString(),onTap: (){}),
                    SizedBox(height: 20,),
                    rowRecButtonList("学生画像",children: [
                      recButton('体貌特征', 'images/timaotezheng.png', () {}),
                      recButton('性格特点', 'images/xinggetedian.png', () {}),
                      recButton('兴趣爱好', 'images/xingquaihao.png', () {}),
                      recButton('家庭经济', 'images/jiatingjingji.png', () {}),
                      recButton('成绩与奖励', 'images/chengjiyujiangli.png', () {}),
                    ]),
                    SizedBox(height: 20,),
                    rowButtonWithContent("谈话记录", "无"),
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
