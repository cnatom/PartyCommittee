//跳转到当前页面
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/qingjiaResultTea_info.dart';
import 'package:party_committee/NetRequest/qingjiaResult_get.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/toast.dart';

void toQingjiaTeaPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => QingjiaTeaPage()));
}

class QingjiaTeaPage extends StatefulWidget {
  @override
  _QingjiaTeaPageState createState() => _QingjiaTeaPageState();
}

class _QingjiaTeaPageState extends State<QingjiaTeaPage>
    with SingleTickerProviderStateMixin {
  TabController mController;
  List _scrollController = [
    new ScrollController(),
    new ScrollController(),
    new ScrollController(),
  ];
  List<int> currentPage = [1,1,1];
  List _crossFadeState =[
    List.filled(22, CrossFadeState.showSecond),
    List.filled(22, CrossFadeState.showFirst),
    List.filled(22, CrossFadeState.showFirst)
  ]; //控制详细列表的展开闭合
  //初始化请假信息列表数据
  Future<Null> _loadingQingjiaInfo({@required int index,int current = 1})async{
    await qingjiaResultTeaGet(context,
        index: index, token: Global.token, status: '${index}', current: '${current}');
    setState(() {
    });
  }
  Future<Null> _initQingjiaInfo() async {
    _loadingQingjiaInfo(index: 0);
    _loadingQingjiaInfo(index: 1);
    _loadingQingjiaInfo(index: 2);
  }
  Future<Null> _agreeOrRefuse({@required String id,@required String status})async{
    try{
      Response res;
      Dio dio = Dio();
      //配置dio信息
      res = await dio.put(
        "https://xyt-wx.cumt.edu.cn/api/leaves",
        data: {
          "id": id,
          "status": status
        },
        options: Options(headers: {'Authorization':Global.token})
      );
      debugPrint(res.toString());
      //Json解码为Map
      Map<String,dynamic> map = jsonDecode(res.toString());
      showToast(context, map['message'],duration: 1);
    }catch(e){
      debugPrint(e.toString());
    }
  }

  //销毁控制器
  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _initQingjiaInfo();
    //初始化控制器
    mController = TabController(
      length: 3,
      vsync: this,
    );
  }

  Widget _switchPageArea({@required int index}) {
    return Global.qingjiaresultTeaInfoList[index] == null
        ? Container()
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            if(currentPage[index]>1){
              _loadingQingjiaInfo(index: index,current: --currentPage[index]);
            }else{
              showToast(context, '已经到首页了(~_~)');
            }
          },
          child: Text("上一页",style: TextStyle(fontSize: fontSizeMini35)),
        ),
        Text(
            "${Global.qingjiaresultTeaInfoList[index].current}/${Global.qingjiaresultTeaInfoList[index].pages}",style: TextStyle(fontSize: fontSizeNormal40)),
        FlatButton(
          onPressed: () {
            if(currentPage[index]<int.parse(Global.qingjiaresultTeaInfoList[index].pages)){
              _loadingQingjiaInfo(index: index,current: ++currentPage[index]);
            }else{
              showToast(context, '已经到尾页了(O_O)');
            }
          },
          child: Text("下一页",style: TextStyle(fontSize: fontSizeMini35),),
        ),
      ],
    );
  }
  Widget _infoList(BuildContext context, {@required int index}) {
    int _index = 0;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: Colors.white,
        onPressed: () {
          _crossFadeState[index] =
          _crossFadeState[index][0] == CrossFadeState.showFirst
              ? List.filled(22, CrossFadeState.showSecond)
              : List.filled(22, CrossFadeState.showFirst);
          setState(() {});
        },
        child: Icon(
          MdiIcons.unfoldMoreHorizontal,
          color: mainColor,
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController[index],
        child: Column(
          children: <Widget>[
            _switchPageArea(index: index),
            Wrap(
              children: Global.qingjiaresultTeaInfoList[index].records.map((item) {
                int curIndex = _index++;
                return Container(
                  margin: EdgeInsets.fromLTRB(fontSizeMini35 * 1.5, fontSizeMini35*0.4,
                      fontSizeMini35 * 1.5, fontSizeMini35 * 0.4),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        _crossFadeState[index][curIndex] =
                        _crossFadeState[index][curIndex] == CrossFadeState.showFirst
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst;
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(fontSizeMini35 * 1.5, fontSizeMini35, fontSizeMini35 * 1.5, fontSizeMini35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${item.name} ",
                                          style: TextStyle(
                                              fontSize: fontSizeNormal40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("(${item.stuNum})",style: TextStyle(fontSize: fontSizeMini35,color: Colors.black54),)
                                      ],
                                    ),
                                    index!=0?Text(
                                      item.status == 1 ? '审核人：${item.reviewerId}' : '审核人：${item.reviewerId}',
                                      style: TextStyle(
                                          fontSize: fontSizeNormal40, color: mainColor),
                                    ):Container()
                                  ],
                                ),
                                Container(
                                  height: fontSizeMini35,
                                ),
                                Text("学院：${item.department}",style: TextStyle(fontSize: fontSizeMini35))
                              ],
                            ),
                            AnimatedCrossFade(
                              firstChild: Container(),
                              secondChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Divider(
                                    height: fontSizeMini35 * 2,
                                  ),
                                  Text(
                                    '''开始时间：${item.startDate}
                \n结束时间：${item.endDate}
                \n请假去向：${item.movement}
                \n请假原因：${item.reason}
                \n紧急联系人：${item.emergencyCaller}
                \n紧急联系人电话：${item.emergencyTel}
                ''',
                                    style: TextStyle(fontSize: fontSizeMini35),
                                  ),
                                  Divider(),
                                  Text(
                                    "申请时间：${item.createTime}",
                                    style: TextStyle(
                                        fontSize: fontSizeMini35,
                                        color: Colors.black38),
                                  ),
                                  SizedBox(height: fontSizeMini35,),
                                  index==0?Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child:MyFlatButtonWithoutGradient('同意',onTap: ()async{
                                          await _agreeOrRefuse(id: item.id,status: '1');
                                          await _loadingQingjiaInfo(index: 0,current: currentPage[0]);
                                          await _loadingQingjiaInfo(index: 1,current: currentPage[1]);
                                          setState(() {});
                                        },),
                                      ),
                                      SizedBox(width: fontSizeMini35,),
                                      Expanded(
                                        flex: 2,
                                        child:MyFlatButtonWithoutGradient('拒绝',onTap: ()async{
                                          await _agreeOrRefuse(id: item.id,status: '2');
                                          await _loadingQingjiaInfo(index: 0,current: currentPage[0]);
                                          await _loadingQingjiaInfo(index: 2,current: currentPage[2]);
                                          setState(() {});
                                        },color: Colors.redAccent),
                                      )
                                    ],
                                  ):Container()
                                ],
                              ),
                              duration: Duration(milliseconds: 200),
                              crossFadeState: _crossFadeState[index][curIndex],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            _switchPageArea(index: index),
            SizedBox(height: fontSizeNormal40*10,)
          ],
        ),
      ),
    );
  }

//  Container(
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.circular(20),
//  ),
//  margin: EdgeInsets.fromLTRB(
//  fontSizeMini35 * 1.5,
//  fontSizeMini35,
//  fontSizeMini35 * 1.5,
//  fontSizeMini35 * 0.5),
//  padding: EdgeInsets.all(fontSizeMini35 * 1.5),
//  child: ,
//  )
  Widget TabBarViewChild({@required int index}) {
    return Global.qingjiaresultTeaInfoList[index].records == null
        ? Center(
            child: loadingAnimationIOS(),
          )
        : Global.qingjiaresultTeaInfoList[index].records.isEmpty
            ? MyFullScreenButton('无请假记录\n(点按空白处刷新)', onTap: () async {
                await qingjiaResultTeaGet(context,
                    index: index,
                    token: Global.token,
                    status: '${index}',
                    current: "${currentPage[index]}");
                setState(() {});
              })
            : _infoList(context, index: index);
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
            TabBarViewChild(index: 0),
            TabBarViewChild(index: 1),
            TabBarViewChild(index: 2),
          ],
        ));
  }
}
