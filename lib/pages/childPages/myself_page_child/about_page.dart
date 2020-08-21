import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/animationEffect/custome_router.dart';


//跳转到当前页面
void toAboutPage(BuildContext context) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => AboutPage()));

}

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
//  void getAppVersion()async{
//    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    appVersion = packageInfo.version;
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: MyAppBarWhite(context, '关于'),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Container(
              height: deviceHeight,
              child: Wrap(
                children: <Widget>[
                  Container(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        elevation: 3,
                        shadowColor: shadowColor.withAlpha(150),
                        borderRadius: BorderRadius.circular(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'images/logo.png',
                            height: 70,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Container(height: 15,),
                  Container(
                    alignment: Alignment.center,
                    child:Text("矿大校园通",style: TextStyle(fontSize: 15),),
                  ),
                  Container(height: 5,),
                  Container(
                    alignment: Alignment.center,
                    child: Text("版本 0.0.1",style: TextStyle(fontSize: 15,color: Colors.black.withAlpha(150)),),
                  ),
                  Container(height: 30,),
                  Container(
                    padding: EdgeInsets.all(40),
                    child: Text("       欢迎使用矿大校园通！这是矿大专属校园App，为校内师生及员工提供办公、管理、校园资讯、信息查询等服务。"
                        "校内师生使用学号/工号认证即可登录",style: TextStyle(fontSize: 17,letterSpacing: 1,color: mainTextColor),),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child:Text("学工处、黑天鹅互联网工作室  联合维护",style: TextStyle(fontSize: 16,color: Colors.black.withAlpha(150)),),
          )
        ],
      ),
    );
  }


}

