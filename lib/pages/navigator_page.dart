
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:party_committee/NetRequest/app_upgrade.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:party_committee/pages/childPages/diy_page.dart';
import 'package:party_committee/pages/childPages/home_page.dart';
import 'package:party_committee/pages/childPages/myself_page.dart';

//跳转到当前页面
void toNavigatorPage(BuildContext context) async{

  Navigator.of(context).pushAndRemoveUntil(CustomRoute(NavigatorPage(),milliseconds: 500),(route)=>route==null);
}

//底部导航栏页面,位于子页面的顶端
class NavigatorPage extends StatefulWidget {
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> with AutomaticKeepAliveClientMixin{
  int _currentIndex = 0; //数组索引，通过改变索引值改变视图
  //创建视图数组
  List<Widget> pageList;



  @override
  void initState() {
    super.initState();
    pageList = [
      HomePage(),
      DiyPage(),
      MyselfPage()];
    upgradeApp(context,auto: true);//检查更新

  }

  @override
  Widget build(BuildContext context) {
    var _pageController = PageController();
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      body: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index)=>pageList[index],
        itemCount: pageList.length,
        controller: _pageController,
        onPageChanged: (int index){
          setState(() {
            if(_currentIndex!=index) _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: mainColor,
          unselectedItemColor: Colors.black87,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                title: Text("主页"),
                icon: Icon(
                  FeatherIcons.home,
                )),
            BottomNavigationBarItem(
                title: Text("功能"),
                icon: Icon(
                  OMIcons.explore,
                )),
            BottomNavigationBarItem(
                title: Text("我的"),
                icon: Icon(
                  OMIcons.person,
                ))
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            _pageController.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
