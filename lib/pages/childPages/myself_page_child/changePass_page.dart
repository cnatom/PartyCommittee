import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/student_info.dart';
import 'package:party_committee/NetRequest/changepass_post.dart';
import 'package:party_committee/NetRequest/signout_post.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/appBar.dart';
import 'package:party_committee/UI_Widget/buttons.dart';
import 'package:party_committee/UI_Widget/colors.dart';
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
    if(newPasswordController.text.length < 6){
      Toast.show("密码长度最低6位", context,backgroundRadius: 20,gravity: Toast.CENTER,duration: 2);
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
        Toast.show("密码更新成功！", context,backgroundRadius: 20,gravity: Toast.CENTER,duration: 1);
        Future.delayed(Duration(seconds: 1), (){
          Navigator.of(context).pushAndRemoveUntil(CustomRoute(LoginPage()),(route) => route == null);
        });

      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: MyAppBarWhite(context, "修改密码"),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Text(
                  "旧密码:",
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black38, width: 0.1)),
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: TextField(
                  controller: oldPasswordController,
                  decoration: InputDecoration(
                    hintText: "在此输入旧密码",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Text(
                  "新密码:",
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black38, width: 0.1)),
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: TextField(
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    hintText: "新密码至少6位",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height:80,),
              //确定按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(0),
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: mainColor,
                      child:InkWell(
                        onTap: ()=>_determineFunc(),
                        child: Container(
                          height: 40,
                          width: deviceWidth/3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text("确定",style: TextStyle(fontSize: 15,color: Colors.white,letterSpacing: 10,fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
