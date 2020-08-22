//第四个"我的"页面

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/signout_post.dart';
import 'package:party_committee/NetRequest/user_info_get.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/bezier_curve.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/containers.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:party_committee/pages/childPages/myself_page_child/about_page.dart';
import 'package:party_committee/pages/childPages/myself_page_child/changePass_page.dart';
import 'package:party_committee/pages/childPages/myself_page_child/studentInfo_page.dart';
import 'package:party_committee/pages/childPages/myself_page_child/teacherInfo_page.dart';
import 'package:party_committee/pages/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_page.dart';

class MyselfPage extends StatefulWidget {
  @override
  _MyselfPageState createState() => _MyselfPageState();
}

class _MyselfPageState extends State<MyselfPage>
    with AutomaticKeepAliveClientMixin {
  void _signOutFunc() async {
    final prefs = await SharedPreferences.getInstance();
    final _token = prefs.getString('token');
    await signOutPost(context, _token);
    toLoginPage(context);
  }

  //确定退出
  Future<bool> _willSignOut(context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text(
              '你确定要退出登录吗?',
              style: TextStyle(color: mainTextColor),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _signOutFunc(),
                child: Text('确定'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('取消'),
              ),
            ],
          ),
        ) ??
        false;
  }

  //提前加载个人信息用于预览名字账号
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
    build(context);
    super.initState();
    setState(() {
      _loadingUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: MyMainAppBar("我的", action: [
        IconButton(
          onPressed: () => _willSignOut(context),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Entypo.logout,
            color: mainTextColor,
          ),
        )
      ]),
      body: RefreshIndicator(
        onRefresh: () => _loadingUserInfo(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: deviceHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MyselfCard(
                    imageResource: "images/test.png",
                    name: Global.name == null ? "加载中..." : Global.name,
                    id: Global.id == null ? "......." : Global.id,
                    onTap: () => Global.admin == 0
                        ? toStudentInfoPage(context)
                        : toTeacherInfoPage(context)),
                MyTitle("设置"),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyRecButton2("修改密码", 'images/xiugai.png',
                          onTap: () => toChangePassPage(context)),
                      MyRecButton2("关于", 'images/guanyu.png',
                          onTap: () => toAboutPage(context),
                          onLongPress: () => showToast(
                              context,
                              '技术支持：\n\n'
                                  '前端：牟金腾 19级计算机\n\n'
                                  '后端：高远     18级计算机\n\n'
                                  '            魏敬杨 18级计算机',
                              duration: 3)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
