import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/app_upgrade.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/buttons.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:party_committee/pages/childPages/myself_page_child/about_page_child/yinsi_page.dart';
import 'package:party_committee/pages/childPages/myself_page_child/about_page_child/yonghu_page.dart';
import 'package:toast/toast.dart';

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
      body: Container(
        height: deviceHeight,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Material(
                    elevation: 3,
                    shadowColor: shadowColor.withAlpha(150),
                    borderRadius: BorderRadius.circular(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'images/logo.png',
                        height: ScreenUtil().setWidth(160),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(50),),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "矿大校园通 - 尝鲜版",
                      style: TextStyle(fontSize: fontSizeMini35,),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "版本 ${Global.curVersion}",
                      style: TextStyle(
                          fontSize: fontSizeMini35, color: Colors.black.withAlpha(150)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(40),
                child: Text(
//                      "       欢迎使用矿大校园通！这是矿大专属校园App，为校内师生及员工提供办公、管理、校园资讯、信息查询等服务。"
//                      "校内师生使用学号/工号认证即可登录\n"
                  "       开发者寄语：校园通App目前处于开发前期，有很多天马行空的功能正在实现，不久以后会登陆IOS甚至Windows端。"
                      "我们会在接下来的日子继续用心“雕琢”，感谢您能与我们一同见证她的成长。",
                  style: TextStyle(fontSize: fontSizeMini35, letterSpacing: 1),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Material(
                    color: Colors.black.withAlpha(8),
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => upgradeApp(context),
                      child: Container(
                        height: ScreenUtil().setHeight(110),
                        width: deviceWidth * 0.7,
                        alignment: Alignment.center,
                        child: Text(
                          "检查更新",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: mainColor.withAlpha(230),
                              fontSize: fontSizeMini35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      greyFlatButton("用户协议",
                          onPressed: () => toYonghuPage(context)),
                      Container(
                        height: ScreenUtil().setWidth(35),
                        width: 1,
                        color: Colors.black.withAlpha(60),
                      ),
                      greyFlatButton("隐私政策",
                          onPressed: () => toYinsiPage(context)),
                    ],
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
