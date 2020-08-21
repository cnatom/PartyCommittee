import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/login_post.dart';
import 'package:party_committee/NetRequest/signout_post.dart';
import 'package:party_committee/UI_Widget/containers.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:party_committee/pages/navigator_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../UI_Widget/colors.dart';
import 'new_navigator_page.dart';

//跳转到当前页面
void toLoginPage(BuildContext context) async {
  Navigator.of(context).pushAndRemoveUntil(
      CustomRoute(LoginPage(), milliseconds: 1000), (route) => route == null);
//  Navigator.push(
//      context, CupertinoPageRoute(builder: (context) => LoginPage()));
}

//登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passWordController = new TextEditingController();
  String _username; //账号
  String _password; //密码
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //表单状态
  //点击登录后的行为
  _loginFunc() async {
    var _form = _formKey.currentState;
    _form.save();
    try {
      await loginPost(username: _username, password: _password);
      if (Global.loginInfo.code != 0) {
        showToast(
            context,
            Global.loginInfo.message == null
                ? "登录失败,请检查您的网络连接"
                : Global.loginInfo.message);
      } else {
        toNavigatorPage(context);
      }
    } catch (e) {
      showToast(context, "登录失败,请检查您的网络连接");
    }
  }
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;



    //忘记密码按钮
    Widget forgetButtonArea = FlatButton(
      onPressed: () => Toast.show('请联系辅导员老师修改密码\n（默认密码为您的8位生日）', context,
          gravity: Toast.CENTER, duration: 2),
      highlightColor: Colors.transparent, //点击后的颜色为透明
      splashColor: Colors.transparent, //点击波纹的颜色为透明
      child: Text(
        "忘记密码",
        style: TextStyle(
            color: Colors.black.withAlpha(100), //字体颜色
            fontWeight: FontWeight.bold, //字重
            fontSize: 13),
      ),
    );

    //登录按钮
    Widget loginButtonArea() => FlatButton(
          padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
          onPressed: () => _loginFunc(),
          color: mainColor,
          child: Text(
            "登录",
            style: TextStyle(
                letterSpacing: 10, //字间距
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
        );

    //输入文本框区域
    Widget inputTextArea() => Container(
          child: new Form(
            //表单
            key: _formKey,
            child: Wrap(
              runSpacing: deviceHeight * 0.04,
              children: <Widget>[
                //账号输入框243,245,247
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243,245,247),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  child: TextFormField(
                    obscureText: false, //是否是密码
                    controller: _userNameController, //控制正在编辑的文本。通过其可以拿到输入的文本值
                    decoration: InputDecoration(
                      hintStyle: TextStyle(),
                      border: InputBorder.none, //隐藏下划线
                      hintText: "学号/工号", //点击后显示的提示语
                    ),
                    onSaved: (String value) {
                      //在_form.save()方法后执行
                      _username = value; //保存用户名
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243,245,247),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passWordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "输入密码",
                    ),
                    onSaved: (String value) {
                      //在_form.save()方法后执行
                      _password = value;
                    },
                  ),
                ),
                //忘记密码按钮
                Container(height: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[loginButtonArea()],
                ),
                Container(
                  alignment: AlignmentDirectional.center,
//              color: Colors.white,
                  child: forgetButtonArea,
                ),
              ],
            ),
          ),
        );

    Widget loadingPage() => Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned(
                height: deviceHeight,
                width: deviceWidth,
                child: Image.asset(
                  'images/login_background.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Opacity(
                    opacity: 0.2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );

    return Scaffold(

        backgroundColor: Colors.white,
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            //背景图
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Opacity(
                  opacity: 0.2,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: deviceHeight,
                alignment: AlignmentDirectional.center,
                padding: EdgeInsets.fromLTRB(
                    deviceWidth * 0.05, 0, deviceWidth * 0.05, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        "images/xiaoyuantong.png",
                        cacheHeight: 30,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: inputTextArea(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
