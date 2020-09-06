import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/chengji_info.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/toast.dart';

//跳转到当前页面
void toChengjiPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => ChengjiPage()));
}

class ChengjiPage extends StatefulWidget {
  @override
  _ChengjiPageState createState() => _ChengjiPageState();
}

class _ChengjiPageState extends State<ChengjiPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;
  List _crossFadeState =
      new List.filled(50, CrossFadeState.showFirst); //控制详细列表的展开闭合
  String _xuenian;
  String _xueqi;
  List<String> _xuenianData;
  List<String> _xueqiData;

  void _showXueqiPicker(BuildContext context) {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(pickerdata: _xueqiData),
        changeToFirst: false,
        textAlign: TextAlign.left,
        textStyle: const TextStyle(color: Colors.black),
        selectedTextStyle: TextStyle(color: mainColor),
        columnPadding: const EdgeInsets.all(20),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _xueqi = picker.getSelectedValues()[0].toString();
          });
        });
    picker.show(_scaffoldKey.currentState);
    setState(() {});
  }

  void _showXuenianPicker(BuildContext context) {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(pickerdata: _xuenianData),
        changeToFirst: false,
        textAlign: TextAlign.left,
        textStyle: const TextStyle(color: Colors.black),
        selectedTextStyle: TextStyle(color: mainColor),
        columnPadding: const EdgeInsets.all(20),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _xuenian = picker.getSelectedValues()[0].toString().substring(0, 4);
            print(_xuenian);
          });
        });
    picker.show(_scaffoldKey.currentState);
    setState(() {});
  }

  //成绩查询
  Future<Null> _chengjiGet(String xueqi, String xuenian, String token) async {

    xueqi == "1" ? xueqi = "3" : xueqi = "12";
    Response res;
    BaseOptions baseOptions = BaseOptions(
        method: 'get',
        baseUrl: "https://kddgw.wjy2000.cn",
        queryParameters: {"xnm": xuenian, "xqm": xueqi},
        headers: {"Authorization": token});
    Dio _dio = Dio(baseOptions);
    try {
      res = await _dio.get("/api/v1/stu_grade");
      debugPrint(res.toString());
      Map<String, dynamic> map = jsonDecode(res.toString());
      setState(() {
        _loading = false;
        _crossFadeState = List.filled(50, CrossFadeState.showFirst);
        Global.chengjiInfo = ChengjiInfo.fromJson(map);
        if (Global.chengjiInfo.code == 0 && Global.chengjiInfo.data.isEmpty) {
          showToast(context, "没有这学期的成绩(>_<)");
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _loading = false;
      });
      showToast(context, "查询失败,请检查您的网络连接(x_x)");
    }
  }

  void _inquireFunc() {
    setState(() {
      _loading = true; //加载动画开启
    });
    if (Global.admin == 0) {
      _chengjiGet(_xueqi, _xuenian, Global.loginInfo.data.token);
    } else {
      setState(() {
        _loading = true;
      });
      setState(() {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _loading = false;
            showToast(context, "没有查到您的成绩(>_<)");
          });
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _xuenianData = [
      "2020-2021",
      "2019-2020",
      "2018-2019",
      "2017-2018",
      "2016-2017"
    ];
    _xueqiData = ["1", "2"];
    _xueqi = "1";
    _xuenian = "2019";
  }

  @override
  void dispose() {
    super.dispose();
    if (Global.chengjiInfo.data != null) {
      Global.chengjiInfo.data.clear();
    }
  }

  @override
  void didChangeDependencies() {
    build(context);
    super.didChangeDependencies();
  }

  //选择区域
  Widget _chooseItemArea(
      String leftText, String rightText, GestureTapCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          leftText,
          style: TextStyle(
            fontSize: fontSizeMini35,
          ),
        ),
        Material(
          color: iconBackColor,
          elevation: 1,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
          child: InkWell(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: fontSizeMini35*2.5,
              width: fontSizeMini35*8,
              child: Text(
                rightText,
                style: TextStyle(fontSize: fontSizeMini35),
              ),
            ),
          ),
        )
      ],
    );
  }

  //绩点:0.5
  Widget _rowContent(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          "$title：",
          style: TextStyle(fontSize: fontSizeMini35),
        ),
        Text(
          content,
          style: TextStyle(fontSize: fontSizeMini35, color: mainColor),
        )
      ],
    );
  }

  //成绩列表
  Widget _scoreCardArea() {
    int index = 0;
    return Column(
      children: Global.chengjiInfo.data == null
          ? [Container()]
          : Global.chengjiInfo.data.map((item) {
              int curIndex = index++;
              List scoreDetail = json.decode(item.cjzc
                  .replaceAll("'", '"')
                  .replaceAll('【', '')
                  .replaceAll('】', '')
                  .toString());
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setWidth(40),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
                    elevation: 2,
                    shadowColor: Colors.black45,
                    child: Container(
                      padding: EdgeInsets.all(fontSizeMini35),
                      width: deviceWidth * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          //课程名   总评:100
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black45,
                                    size:fontSizeNormalTitle45
                                  ),
                                  Text(
                                    " " + item.kcmc,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: fontSizeMini35,
                                    ),
                                  )
                                ],
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
                                    color: mainColor.withAlpha(210),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
                                      onTap: () {
                                        _crossFadeState[curIndex] =
                                            _crossFadeState[curIndex] ==
                                                    CrossFadeState.showFirst
                                                ? CrossFadeState.showSecond
                                                : CrossFadeState.showFirst;
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: fontSizeMini35*6,
                                        height: fontSizeMini35*2.2,
                                        child: Text(
                                          "总评：${item.bfzcj}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSizeMini35),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          Divider(
                            height: ScreenUtil().setWidth(50),
                          ),
                          //学分 绩点
                          Container(
                            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(20), 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _rowContent('学分', item.xf),
                                _rowContent('绩点', item.jd),
                              ],
                            ),
                          ),
                          //开展区域
                          AnimatedCrossFade(
                            firstChild: Container(),
                            secondChild: Column(
                              children: <Widget>[
                                Divider(
                                  height: ScreenUtil().setWidth(60),
                                ),
                                Row(
                                    children: scoreDetail.map((item) {
                                  return Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          item["component_ratio"] != "0%"
                                              ? "${item["component_name"]} (${item["component_ratio"]})"
                                              : "${item["component_name"]}",
                                          style: TextStyle(fontSize: fontSizeMini35),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setWidth(30),
                                        ),
                                        Text(
                                          "${item["component_score"]}",
                                          style: TextStyle(
                                              fontSize: fontSizeMini35, color: mainColor),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList())
                              ],
                            ),
                            duration: Duration(milliseconds: 200),
                            crossFadeState: _crossFadeState[curIndex],
                          ),
//                                  _buildSwitch(),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBarColorful(context, "成绩查询"),
      backgroundColor: pageBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            //主题色底图
            Positioned(
              child: Container(
                height: ScreenUtil().setWidth(200),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [mainColor, mainColor.withAlpha(200)])),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //选择区
                SizedBox(
                  height: ScreenUtil().setWidth(20),
                ),
                Material(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
                  color: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.black26,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), fontSizeNormal40, ScreenUtil().setWidth(60), fontSizeNormal40),
                    width: deviceWidth * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _chooseItemArea(
                            "选择年份",
                            _xuenian == null
                                ? "null"
                                : "${_xuenian}-${int.parse(_xuenian) + 1}",
                            () => _showXuenianPicker(context)),
                        Divider(
                          height: ScreenUtil().setWidth(50),
                        ),
                        _chooseItemArea("选择学期", "第 ${_xueqi} 学期",
                            () => _showXueqiPicker(context))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(40),
                ),
                MyFlatButton("查询", onTap: () => _inquireFunc()),
                _loading == null
                    ? Container()
                    : _loading == true
                        ? Column(
                  children: <Widget>[
                    loadingAnimationArticle(),
                    loadingAnimationArticle(),
                    loadingAnimationArticle(),
                    loadingAnimationArticle(),

                  ],
                )
                        : _scoreCardArea(),
                SizedBox(
                  height: 100,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
