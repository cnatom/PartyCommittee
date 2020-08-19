import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/new_bottomBar/animated_bottom_bar.dart';
import 'package:party_committee/animationEffect/custome_router.dart';

import 'childPages/diy_page.dart';
import 'childPages/home_page.dart';
import 'childPages/myself_page.dart';
import 'navigator_page.dart';

//跳转到当前页面
void toNewNavigatorPage(BuildContext context) {
  Navigator.of(context).push(CustomRoute(NewNavigatorPage(),milliseconds: 1500));
}

class NewNavigatorPage extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(
      text: "主页",
      iconData: Icons.home,
      color: mainColor,
    ),
    BarItem(
      text: "功能",
      iconData: Icons.favorite_border,
      color: mainColor,
    ),
    BarItem(
      text: "我的",
      iconData: Icons.search,
      color: mainColor,
    ),
  ];

  @override
  _NewNavigatorPageState createState() =>
      _NewNavigatorPageState();
}

class _NewNavigatorPageState
    extends State<NewNavigatorPage> {
  int _currentIndex = 0;

  //创建视图数组
  List<Widget> pageList = [
    HomePage(),
    DiyPage(),
    MyselfPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_currentIndex],
      bottomNavigationBar: AnimatedBottomBar(

          barItems: widget.barItems,
          animationDuration: const Duration(milliseconds: 150),
          barStyle: BarStyle(
            fontSize: 20.0,
            iconSize: 30.0
          ),
          onBarTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
