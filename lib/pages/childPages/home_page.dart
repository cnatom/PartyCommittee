//第一个主页页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_committee/NetRequest/swiper_get.dart';
import 'package:party_committee/UI_Widget/swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.67,
            child: swiperWidget(),
          ),
        ],
      ),
    );
  }
}
