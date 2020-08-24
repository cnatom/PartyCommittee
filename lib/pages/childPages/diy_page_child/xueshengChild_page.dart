import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/user_info_get.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/perInfoWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

//跳转到当前页面
void toXueshengChildPage(BuildContext context) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => XueshengChildPage()));
}

class XueshengChildPage extends StatefulWidget {
  @override
  _XueshengChildPageState createState() => _XueshengChildPageState();
}

class _XueshengChildPageState extends State<XueshengChildPage> {
  //加载页面数据
  void _loadStuInfo()async{
    if(Global.studentInfo.data==null){
      final token = (await SharedPreferences.getInstance()).getString('token');
      await userInfoGet(token);
      setState(() {
      });
    }
  }
  @override
  void didChangeDependencies() {
    build(context);
    super.didChangeDependencies();
    _loadStuInfo();
  }

  List _infodata1 = [
    {"电话": "13070708211", "邮箱": "1004275481@qq.com"},
    {'身份证': '370786200001254266', "姓名拼音": "mujinteng"},
    {'毕业学校': '山东实验中学', "政治面貌": "共青团员"},
    {"生源地": '山东省', '家庭住址': '江苏省徐州市大学路一号'},

  ];
  List _infodata2 = [
    {"班级": "计算机类19-9班", "寝室": "M2B1052"},
    {"辅导员": "张菁","紧急联系人": "阿腾木"},
    {'辅导员电话':'15254625111',"紧急联系人电话": "13022152364"},
  ];
  List<Widget> _rowButtonChildren = [
    recButton('体貌特征', 'images/timao.png', () {}),
    recButton('性格特点', 'images/xingge.png', () {}),
    recButton('兴趣爱好', 'images/xingqu.png', () {}),
    recButton('家庭经济', 'images/jiating.png', () {}),
    recButton('成绩与奖励', 'images/chengji.png', () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Global.studentInfo.data==null?AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: ()=>Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios,color: mainColor,),
          ),
        ):null,
        backgroundColor: pageBackgroundColor,
        body: Global.studentInfo.data==null
            ?Center(child: loadingAnimationWave,)
            :CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            stuInfoSliverAppBar(
                context,
                photo: 'images/test.jpg',
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
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    infoCardArea("基本信息",data: _infodata1),
                    SizedBox(height: 20,),
                    infoCardArea("在校信息",data: _infodata2),
                    SizedBox(height: 20,),
                    rowButtonWithoutContent("学生成绩",onTap: (){}),
                    SizedBox(height: 20,),
                    rowButtonWithContent("心理等级", '三级'),
                    SizedBox(height: 20,),
                    rowButtonWithContent("经济援助", '暂无',onTap: (){}),
                    SizedBox(height: 20,),
                    rowButtonWithContent("获奖情况", "19-20学年校二等奖学金(院优秀学生)\n19-20学年校二等奖学金(院优秀学生)",onTap: (){}),
                    SizedBox(height: 20,),
                    rowRecButtonList("学生画像",children: _rowButtonChildren),
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
