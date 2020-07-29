
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_committee/pages/childPages/course_page.dart';
import 'package:party_committee/pages/childPages/diy_page.dart';
import 'package:party_committee/pages/childPages/home_page.dart';
import 'package:party_committee/pages/childPages/myself_page.dart';

class NavigatorPage extends StatefulWidget {
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _currentIndex = 0; //数组索引，通过改变索引值改变视图
  List<Widget> list = List(); //创建视图数组
  @override
  void initState() {
    //将页面添加进数组中
    list..add(HomePage())..add(CoursePage())..add(DiyPage())..add(MyselfPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 8,
          items: [
            BottomNavigationBarItem(
                title: Text("导航"),
                icon: Icon(
                  Icons.home,
                )),
            BottomNavigationBarItem(
                title: Text("课表"),
                icon: Icon(
                  Icons.supervised_user_circle,
                )),
            BottomNavigationBarItem(
                title: Text("功能"),
                icon: Icon(
                  Icons.explore,
                )),
            BottomNavigationBarItem(
                title: Text("我"),
                icon: Icon(
                  Icons.explore,
                ))
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed),
    );
  }
}
