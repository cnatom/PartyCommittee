//第一个主页页面
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/news_info.dart';
import 'package:party_committee/NetRequest/news_get.dart';
import 'package:party_committee/NetRequest/signout_post.dart';
import 'package:party_committee/NetRequest/swiper_get.dart';
import 'package:party_committee/NetRequest/user_info_get.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/bezier_curve.dart';
import 'package:party_committee/UI_Widget/buttons.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/containers.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/swiper.dart';
import 'package:party_committee/main.dart';
import 'package:party_committee/pages/childPages/diy_page_child/bangong_page.dart';
import 'package:party_committee/pages/childPages/diy_page_child/ruxiao_page.dart';
import 'package:party_committee/pages/childPages/diy_page_child/xiaoche_page.dart';
import 'package:party_committee/pages/childPages/diy_page_child/xiaoli_page.dart';
import 'package:party_committee/pages/childPages/home_page_child/news_page.dart';
import 'package:party_committee/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../null_page.dart';

//用于取消蓝色回弹效果
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<NetworkImage> swiperImgList; //用于提前缓存轮播图的网络图片

  //加载轮播图、新闻数据
  Future<Null> _loadingInfo() async {

    await swiperGet();
    await newsGet();
    setState(() {
      var swiperImgList = Global.swiperInfo.data
          .map((item) => NetworkImage(item.imgCompressedUrl))
          .toList();
      for (var img in swiperImgList) {
        precacheImage(img, context);
      }
    });
  }
  Future<Null> _refreshNews()async{
    if (Global.newsInfo.data != null) {
      setState(() {
        Global.newsInfo = new NewsInfo();
      });
    }
    await newsGet();
    setState(() {

    });
  }


  @override
  void initState() {
    super.initState();
    _loadingInfo();
  }

  //轮播图区域
  Widget _swiperArea() {
    return Material(
      color: iconBackColor,
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Container(
        width: deviceWidth * 0.9,
        height: deviceWidth * 0.9 * 0.4115,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: swiperWidget(),
        ),
      ),
    );
  }

  //校园资讯列表区域
  Widget schoolNewsArea() {
    return Column(
      children: Global.newsInfo.data.newsList.map((item) {
        return MyNewsItemButton(
            title: item.title,
            time: item.time,
            onTap: () =>
                toNewsPage(context, item.title, item.paragraphs, item.time));
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: pageBackgroundColor,
        appBar: MyMainAppBar("主页"),
        body: RefreshIndicator(
          onRefresh: _refreshNews,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Center(
                  child: _swiperArea(),
                ), //轮播图
                SizedBox(
                  height: 20,
                ),
                MyTitle("常用功能"),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MyRecButton1("入校申请", "Ask of leave", 'images/fanxiao1.png',
                        onTap: () => toRuxiaoPage(context)),
                    MyRecButton1("销假", "Back from leave", 'images/xiaojia1.png',
                        onTap: () => toNullPage(context)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MyTitle("校园资讯"),
                SizedBox(height: 10),
                Global.newsInfo.data != null
                    ? schoolNewsArea()
                    : Container(
                        height: 500,
                        alignment: Alignment.topCenter,
                        child: Wrap(
                          children: <Widget>[
                            loadingAnimationArticle(),
                            loadingAnimationArticle(),
                            loadingAnimationArticle()
                          ],
                        ),
                      )
              ],
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
