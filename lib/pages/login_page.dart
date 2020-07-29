import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UI_Widget/buttons.dart';
import '../UI_Widget/colors.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    bool _light = false;//教职工切换状态判断
    TextEditingController _userNameController = new TextEditingController();
    var _username;//账号
    var _password;//密码
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();//表单状态

    //logo区域
    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      child: Container(
        child: Image.asset(
          "images/logo.png",
          fit: BoxFit.cover,
        ),
        padding: EdgeInsets.fromLTRB(60,0,60,0),
      ),
    );


    //输入文本框区域
    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: new Form(  //表单
        key: _formKey,
        child: new Column(
          children: <Widget>[
            new TextFormField(
              obscureText: true,
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: "账号",
                hintText: "请输入学号",
                prefixIcon: Icon(Icons.person),
              ),
//              validator: validateUserName,
              onSaved: (String value){  //在_form.save()方法后执行
                _username = value;
              },
            ),
            new TextFormField(
              obscureText: true,
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "默认为您的8位生日",
                prefixIcon: Icon(Icons.lock),
              ),
//              validator: validateUserName,
              onSaved: (String value){  //在_form.save()方法后执行
                _password = value;
              },
            ),
          ],
        ),
      ),
    );

    //切换教职工登录区
    Widget teacherArea = Container(
        child: ListTile(
          title: Text("教职工登录"),
          trailing: CupertinoSwitch(
            activeColor: mainColor,
            value: _light,
            onChanged: (bool value){
              setState(() {
                _light = value;
              });
            },
          ),
          onTap: (){
            setState(() {
              _light = !_light;
            });
          },
        )
    );

    //登录按钮
    Widget loginButtonArea = Container(
      width: 300,
      alignment: Alignment.center,
      child: mainButton(
          text: Text('登录'),
          onPressed: (){Navigator.of(context).pushReplacementNamed('NavigatorPage');}
      ),
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          title: Container(
            alignment: Alignment.center,
            child:Text(
                '学工处服务大厅'
            ),
          )
      ),
      body: Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            logoImageArea,
            Column(
              children: <Widget>[
                inputTextArea,
                SizedBox(height: 20,),
                teacherArea
              ],
            ),
            loginButtonArea
          ],
        ),
      ),
    );
  }
}


