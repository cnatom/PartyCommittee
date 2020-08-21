import 'dart:io';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/PickerLocalizationsDelegate.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetRequest/login_post.dart';
import 'package:party_committee/NetRequest/signout_post.dart';
import 'package:party_committee/pages/childPages/myself_page_child/about_page.dart';
import 'package:party_committee/pages/login_page.dart';
import 'package:party_committee/pages/navigator_page.dart';
import 'package:party_committee/pages/new_navigator_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI_Widget/toast.dart';
import 'animationEffect/custome_router.dart';

void main() {
  if (Platform.isAndroid) {
    //设置android状态栏为透明的沉浸。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MaterialApp(
    localizationsDelegates: [
      PickerLocalizationsDelegate.delegate,
    ],
    debugShowCheckedModeBanner: false,
    home: StartPage(),
  ));
}



//启动页,是进入App的第一个页面
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {


  //检测是否联网
  Future<int> isOnline() async{
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) return 0;
  }
  Future<void> _countDown() async {
    //判断是否登陆过
    final prefs = await SharedPreferences.getInstance();
    final _username = prefs.getString('username')??'';
    final _password = prefs.getString('password')??'';
    final _token = prefs.getString('token')??'';
    if(await isOnline()==0){
      showToast(context,"检测到您已断开网络连接(x_x)");
      Future.delayed(Duration(seconds: 2), (){
        toLoginPage(context);
      });
    }else if(_token!=''){
      debugPrint('@token:'+_token);
      //token不为空则重新登录
      signOutPost(context,_token);
      loginPost(username: _username,password: _password);
      toNavigatorPage(context);
    }else{
      toLoginPage(context);
    }
  }




  @override
  void didChangeDependencies() {
    build(context);
    super.didChangeDependencies();
    _countDown();
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //启动时获取设备大小
    print('@build');
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'images/login_background.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
