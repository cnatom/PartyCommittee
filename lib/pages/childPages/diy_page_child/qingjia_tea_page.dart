

//跳转到当前页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';

void toQingjiaTeaPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => QingjiaTeaPage()));
}


class QingjiaTeaPage extends StatefulWidget {
  @override
  _QingjiaTeaPageState createState() => _QingjiaTeaPageState();
}

class _QingjiaTeaPageState extends State<QingjiaTeaPage> with SingleTickerProviderStateMixin{
  TabController mController;
  //销毁控制器
  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }
  @override
  void initState() {
    super.initState();
    //初始化控制器
    mController = TabController(
      length: 3,
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: pageBackgroundColor,
        bottomNavigationBar: Material(
          color: pageBackgroundColor,
          child: TabBar(
              controller: mController,
              indicatorColor: mainColor,
              indicatorWeight: 3,
              labelPadding: EdgeInsets.all(ScreenUtil().setWidth(5)),
              indicatorPadding: EdgeInsets.all(3),
              labelColor: Colors.black,
              labelStyle: TextStyle(
                  fontSize: fontSizeNormal40, fontWeight: FontWeight.bold),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: "待审核",
                ),
                Tab(
                  text: "已批准",
                ),
                Tab(
                  text: "已拒绝",
                )
              ]),
        ),
        appBar: MyAppBarWhite(
          context,
          "请假",
        ),
        body: TabBarView(
          controller: mController,
          children: <Widget>[
            Container(),
            Container(),
            Container(),

          ],
        ));
  }
}
