import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/login_post.dart';
import 'package:party_committee/UI_Widget/containers.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:party_committee/pages/navigator_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../UI_Widget/colors.dart';
import 'new_navigator_page.dart';

//跳转到当前页面
void toLoginPage(BuildContext context) async{
  Navigator.of(context).pushAndRemoveUntil(CustomRoute(LoginPage(),milliseconds: 1000),(route)=>route==null);
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
  bool _light = false;




  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    //点击登录后的行为
    _loginFunc() async {
      var _form = _formKey.currentState;
      _form.save();
      try{
        await loginPost(username: _username,password: _password);
        if (Global.loginInfo.code != 0) {
          showToast(context, Global.loginInfo.message==null?"登录失败,请检查您的网络连接":Global.loginInfo.message);
        }else{
          toNavigatorPage(context);
        }
      }catch(e){
        showToast(context, "登录失败,请检查您的网络连接");
      }
    }

    //logo区域
    Widget logoImageArea = Container(
      height: deviceHeight * 0.25,
      child: Hero(
        tag: 'login_logo',
        child: Image.asset(
          "images/logo_v.png",
        ),
      ),
    );

    //忘记密码按钮
    Widget forgetButtonArea = FlatButton(
      onPressed: () => Toast.show('请联系辅导员老师修改密码', context,
          gravity: Toast.CENTER, duration: 2),
      highlightColor: Colors.transparent, //点击后的颜色为透明
      splashColor: Colors.transparent, //点击波纹的颜色为透明
      child: Text(
        "忘记密码?",
        style: TextStyle(
            decorationColor:
                Color.fromARGB(255, 60, 95, 149).withAlpha(255), //下划线颜色
            color: Color.fromARGB(255, 60, 95, 149).withAlpha(255), //字体颜色
            decoration: TextDecoration.underline, //设置下划线
            fontWeight: FontWeight.w500, //字重
            fontSize: 15),
      ),
    );

    //输入文本框区域
    Widget inputTextArea = new Container(
      height: deviceHeight * 0.3, //账号密码区容器的高度
      child: new Form(
        //表单
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //账号输入框
            Cir_container(
                color: transWhite,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0), //输入文本相对于输入框的边距
                child: new TextFormField(
                  obscureText: false, //是否是密码
                  controller: _userNameController, //控制正在编辑的文本。通过其可以拿到输入的文本值
                  decoration: InputDecoration(
                    labelText: "账号", //点击前显示的文本
                    border: InputBorder.none, //隐藏下划线
                    hintText: "请输入学号", //点击后显示的提示语
                  ),
                  onSaved: (String value) {
                    //在_form.save()方法后执行
                    _username = value; //保存用户名
                  },
                )),
            //密码输入框
            Cir_container(
              color: transWhite,
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0), //输入文本相对于输入框的边距
              child: new TextFormField(
                obscureText: true,
                controller: _passWordController,
                decoration: InputDecoration(
                  labelText: "密码",
                  border: InputBorder.none,
                  hintText: "默认为您的8位生日",
                ),
                onSaved: (String value) {
                  //在_form.save()方法后执行
                  _password = value;
                },
              ),
            ),
            //忘记密码按钮
            Container(
              alignment: AlignmentDirectional.centerEnd,
//              color: Colors.white,
              child: forgetButtonArea,
            ),
          ],
        ),
      ),
    );

    //切换教职工登录区(暂时不用)
    Widget teacherArea() {
      return Container(
          child: ListTile(
        title: Text("教职工登录"),
        //开关控件
        trailing: Switch(
          activeColor: mainColor,
          value: _light,
          onChanged: (bool value) {
            setState(() {
              _light = value;
            });
          },
        ),
        onTap: () {
          //点击后执行
          setState(() {
            print(_light);
            _light = !_light;
          });
        },
      ));
    }

    //登录按钮
    Widget loginButtonArea = FlatButton(
      padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
      onPressed: () => _loginFunc(),
      color: loginButtonColor,
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            //背景图
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
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
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
                alignment: AlignmentDirectional.bottomCenter,
                padding: EdgeInsets.fromLTRB(
                    deviceWidth * 0.05, 0, deviceWidth * 0.05, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    logoImageArea,
                    inputTextArea, //输入框区域
                    loginButtonArea, //登录按钮
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
