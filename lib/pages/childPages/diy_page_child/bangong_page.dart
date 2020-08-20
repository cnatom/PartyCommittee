import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/appBar.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/pages/childPages/diy_page_child/bangong_page_data.dart';

//跳转到当前页面
void toBangongPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => BangongPage()));
}

class BangongPage extends StatefulWidget {
  @override
  _BangongPageState createState() => _BangongPageState();
}

class _BangongPageState extends State<BangongPage>
    with SingleTickerProviderStateMixin {
  TabController mController; //Tab控制器

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
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    //标题行子项
    Widget _titleRowItem(String title) {
      return Container(
        height: 40,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    //正文行子项
    Widget _contentRowItem(String title) {
      return Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: deviceHeight * 0.05,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ));
    }

    //部门通讯录表格
    Widget _tabBarChildView1() {
      return Column(
        children: <Widget>[
          //第一行是标题行,不可滚动
          Table(
            children: [
              //标题行
              TableRow(
                  decoration: BoxDecoration(color: mainColor.withAlpha(230)),
                  children: [
                    _titleRowItem('部门'),
                    _titleRowItem('地址'),
                    _titleRowItem('电话'),
                  ])
            ],
          ),
          //可滚动表格区域
          Flexible(
            flex: 1,
            child: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Table(
                  border:
                      TableBorder.all(color: mainColor.withAlpha(30)), //边框颜色
                  children: departmentData.map((item) {
                    //如果号码是1,说明是子标题,否则只是普通的行
                    if (item['tel'] == '1') {
                      return TableRow(
                          decoration:
                              BoxDecoration(color: mainColor.withAlpha(150)),
                          children: [
                            Container(),
                            Container(
                              height: 35,
                              child: Center(
                                child: Text(
                                  item['depa'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Container()
                          ]);
                    } else {
                      return TableRow(children: [
                        _contentRowItem(item['depa']),
                        _contentRowItem(item['add']),
                        _contentRowItem(item['tel']),
                      ]);
                    }
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      );
    }

    //教职工通讯录表格
    Widget _tabBarChildView2() {
      return Column(
        children: <Widget>[
          //第一行是标题行,不可滚动
          Table(
            border: TableBorder.all(
              color: Colors.white10,
            ),
            children: [
              //标题行
              TableRow(
                  decoration: BoxDecoration(color: mainColor.withAlpha(230)),
                  children: [
                    _titleRowItem('姓名'),
                    _titleRowItem('职务'),
                    _titleRowItem('办公电话'),
                    _titleRowItem('办公室'),
                  ])
            ],
          ),
          //可滚动表格区域
          Flexible(
            flex: 1,
            child: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Table(
                  border:
                  TableBorder.all(color: mainColor.withAlpha(30)), //边框颜色
                  children: teacherData.map((item) {
                    //如果号码是1,说明是子标题,否则只是普通的行
                    if (item['tel'] != '1') {
                      return TableRow(children: [
                          _contentRowItem(item['depa']),
                    _contentRowItem(item['position']),
                    _contentRowItem(item['tel']),
                    _contentRowItem(item['office']),
                    ]);


                    } else {
                      return  TableRow(
                          decoration:
                          BoxDecoration(color: mainColor.withAlpha(150)),
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Center(
                                child: Text(
                                  item['depa'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Container(),
                            Container(),
                            Container()
                          ]
                      );
                    }
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      bottomNavigationBar: Material(
        color: pageBackgroundColor,
        child: TabBar(
            controller: mController,
            indicatorColor:mainColor,
            indicatorWeight: 3,
            labelPadding: EdgeInsets.all(5),
            indicatorPadding: EdgeInsets.all(3),
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                text: "部门通讯录",
              ),
              Tab(
                text: "教职工通讯录",
              )
            ]),
      ),
      appBar: MyAppBarWhite(context, "办公黄页",),
      body: TabBarView(
        controller: mController,
        children: <Widget>[
          _tabBarChildView1(),
          _tabBarChildView2()
        ],
    ));
  }
}