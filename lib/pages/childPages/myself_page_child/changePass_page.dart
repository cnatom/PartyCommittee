import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/student_info.dart';
import 'package:party_committee/NetRequest/changepass_post.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:party_committee/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

//跳转到当前页面
void toChangePassPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => ChangePassPage()));
}


//修改密码页面
class ChangePassPage extends StatefulWidget {
  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  TextEditingController oldPasswordController = new TextEditingController(); //旧密码控制器
  TextEditingController newPasswordController = new TextEditingController(); //新密码控制器
  //点击确定后的行为
  _determineFunc() async{
    if(newPasswordController.text.length < 4){
      showToast(context, '密码最低4位');
    }else{
      final token = await (await SharedPreferences.getInstance()).getString('token');
      await changePassPost(
          token: token,
          oldpwd: oldPasswordController.text.toString(),
          newpwd: newPasswordController.text.toString());
      if(Global.changePassInfo.code!=0){
        Toast.show(Global.changePassInfo.message.toString(), context,backgroundRadius: 20,gravity: Toast.CENTER,duration: 2);
      }else{
        Global.studentInfo = new StudentInfo();
        (await SharedPreferences.getInstance()).clear();
        showToast(context, '密码更新成功！',duration: 1);
        Future.delayed(Duration(seconds: 1), (){
          Navigator.of(context).pushAndRemoveUntil(CustomRoute(LoginPage()),(route) => route == null);
        });

      }
    }
  }

  Widget _inputArea(String title,String hintText,{TextEditingController controller})=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(50), 0, 0, ScreenUtil().setSp(30)),
        child: Text(
          title,
          style: TextStyle(fontSize: fontSizeNormal40, color: Colors.black45),
        ),
      ),
      Container(
        height: ScreenUtil().setSp(120),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black38, width: 0.1)),
        padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(50), 0, 0, 0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: fontSizeNormal40,),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: MyAppBarWhite(context, "修改密码"),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setWidth(50),),
              _inputArea('旧密码：', '在此输入旧密码',controller: oldPasswordController),
              SizedBox(height: ScreenUtil().setWidth(50),),
              _inputArea('新密码：', '新密码至少4位',controller: newPasswordController),
              SizedBox(height: ScreenUtil().setWidth(200),),
              Center(
                child: MyFlatButtonWithoutGradient('确定',onTap: ()=>_determineFunc()),
              )
            ]),
      ),
    );
  }
}
