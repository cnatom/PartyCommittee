import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/app_upgrade.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/animationEffect/custome_router.dart';

//跳转到当前页面
void toAboutPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => AboutPage()));
}

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
                  Container(
                    height: 50,
                  ),
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
                  Container(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "矿大校园通 - 尝鲜版",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "版本 ${Global.curVersion}",
                      style: TextStyle(
                          fontSize: 15, color: Colors.black.withAlpha(150)),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(40),
                    child: Text(
//                      "       欢迎使用矿大校园通！这是矿大专属校园App，为校内师生及员工提供办公、管理、校园资讯、信息查询等服务。"
//                      "校内师生使用学号/工号认证即可登录\n"
                          "       开发者寄语：校园通App目前处于开发前期，有很多天马行空的功能正在实现，不久以后会登陆IOS甚至Windows端。"
                              "我们会在接下来的日子继续用心“雕琢”，感谢您能与我们一同见证她的成长！",
                      style: TextStyle(fontSize: 15, letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Column(
              children: <Widget>[
                //242,242,246
                Material(
                  color: Colors.black.withAlpha(8),
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => upgradeApp(context),
                    child: Container(
                      height: 50,
                      width: deviceWidth * 0.7,
                      alignment: Alignment.center,
                      child: Text(
                        "检查更新",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: mainColor.withAlpha(230),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
//                Text(
//                  "19-牟金腾(前端)、18-高远(后端)、18-魏敬杨(后端)\n学工处  联合制作维护",
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                      fontSize: 12, color: Colors.black.withAlpha(150)),
//                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
