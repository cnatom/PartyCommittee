
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetRequest/app_upgrade.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:party_committee/pages/childPages/diy_page.dart';
import 'package:party_committee/pages/childPages/home_page.dart';
import 'package:party_committee/pages/childPages/myself_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if(Global.igUpgrade!=true){
      upgradeApp(context,auto: true);//用户没有忽略过则检查更新
    }
  }

  BottomNavigationBarItem _bottomNavigationBar(String title,IconData iconData)=>BottomNavigationBarItem(
      title: Text(title,style: TextStyle(fontSize: fontSizeMini35),),
      icon: Icon(
        iconData,
        size: ScreenUtil().setSp(60),
      ));
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
            _bottomNavigationBar('主页',FeatherIcons.home),
            _bottomNavigationBar('功能',OMIcons.explore),
            _bottomNavigationBar('我的',OMIcons.person),
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
