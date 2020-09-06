import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/app_upgrade.dart';
import 'package:party_committee/NetRequest/login_post.dart';
import 'package:party_committee/NetRequest/signout_post.dart';
import 'package:party_committee/UI_Widget/buttons.dart';
import 'package:party_committee/UI_Widget/containers.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:party_committee/pages/childPages/myself_page_child/about_page_child/yonghu_page.dart';
import 'package:party_committee/pages/navigator_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../UI_Widget/colors.dart';
import 'childPages/myself_page_child/about_page_child/yinsi_page.dart';
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
  bool _agree = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //表单状态
  bool _loading = false;
  //点击登录后的行为
  _loginFunc() async {
    if(_agree!=true){
      showToast(context, '请您仔细阅读并同意\n《用户协议》及《隐私政策》');
      return;
    }
    setState(() {
      _loading = true;
    });
    var _form = _formKey.currentState;
    _form.save();
    try {
      await loginPost(username: _username, password: _password);
      if (Global.loginInfo.code != 0) {
        setState(() {
          _loading = false;
        });
        showToast(
            context,
            Global.loginInfo.message == null
                ? "登录失败,请检查您的网络连接"
                : Global.loginInfo.message);
      } else {
        toNavigatorPage(context);
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      showToast(context, "登录失败,请检查您的网络连接");
    }
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //登录按钮
    Widget loginButtonArea() => FlatButton(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(200),
              ScreenUtil().setWidth(35),
              ScreenUtil().setWidth(200),
              ScreenUtil().setWidth(35)),
          onPressed: () => _loginFunc(),
          color: mainColor,
          child: Text(
            "登录",
            style: TextStyle(
                letterSpacing: 10, //字间距
                color: Colors.white,
                fontSize: fontSizeNormal40,
                fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
        );
    Widget inputBar(String hintText, TextEditingController controller,
            {FormFieldSetter<String> onSaved, bool obscureText = false}) =>
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 245, 247),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(25))),
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(70),
              ScreenUtil().setWidth(10),
              ScreenUtil().setWidth(70),
              ScreenUtil().setWidth(10)),
          child: TextFormField(
            style: TextStyle(fontSize: fontSizeNormal40),
            obscureText: obscureText, //是否是密码
            controller: controller, //控制正在编辑的文本。通过其可以拿到输入的文本值
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: fontSizeNormal40),
              border: InputBorder.none, //隐藏下划线
              hintText: hintText, //点击后显示的提示语
            ),
            onSaved: onSaved,
          ),
        ); //输入文本框区域
    Widget inputTextArea() => Container(
          child: new Form(
            //表单
            key: _formKey,
            child: Wrap(
              runSpacing: deviceHeight * 0.04,
              children: <Widget>[
                //账号输入框243,245,247
                inputBar('学号/工号', _userNameController,
                    onSaved: (String value) => _username = value),
                inputBar('输入密码', _passWordController,
                    onSaved: (String value) => _password = value,
                    obscureText: true),
                _loading==false?Wrap(
                  runSpacing: deviceHeight * 0.04,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          activeColor: mainColor,
                          value: _agree,
                          onChanged: (v) => setState(() {_agree=!_agree;}),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: fontSizeMini35,
                                  color: Colors.black38),
                              children: [
                                TextSpan(text: '已同意《'),
                                TextSpan(text: '用户协议',style: TextStyle(decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()..onTap = ()=>toYonghuPage(context)),
                                TextSpan(text: '》及《'),
                                TextSpan(text: '隐私政策',style: TextStyle(decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()..onTap = ()=>toYinsiPage(context)),
                                TextSpan(text: '》'),
                              ]),
                        )
                      ],
                    ),
                    Center(
                      child:loginButtonArea(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        greyFlatButton("忘记密码",
                            onPressed: () => Toast.show(
                                '请联系辅导员老师修改密码\n（默认密码为您的8位生日）', context,
                                gravity: Toast.CENTER, duration: 2)),
                        Container(
                          height: ScreenUtil().setWidth(35),
                          width: 1,
                          color: Colors.black.withAlpha(60),
                        ),
                        greyFlatButton("检查更新",
                            onPressed: () => upgradeApp(context)),
                      ],
                    )
                  ],
                ):Center(
                  child: loadingAnimationTwoCircles,
                )
              ],
            ),
          ),
        );

    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              //背景图
              Positioned(
                child: Container(
                  height: deviceHeight,
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(70), 0, ScreenUtil().setWidth(70), 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Text('CUMT校园通',
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontFamily: 'enblack',
                                  color: mainColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: ScreenUtil().setSp(100),
                                  fontStyle: FontStyle.italic)),
                        ),
                      ),

                      Expanded(
                        flex: 6,
                        child: inputTextArea(),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
