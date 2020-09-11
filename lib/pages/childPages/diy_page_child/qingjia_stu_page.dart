import 'dart:core';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/qingjiaResult_info.dart';
import 'package:party_committee/NetRequest/qingjiaResult_get.dart';
import 'package:party_committee/NetRequest/qingjia_post.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/toast.dart';

//跳转到当前页面
void toQingjiaStuPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => QingjiaStuPage()));
}

class QingjiaStuPage extends StatefulWidget {
  @override
  _QingjiaStuPageState createState() => _QingjiaStuPageState();
}

class _QingjiaStuPageState extends State<QingjiaStuPage>
    with SingleTickerProviderStateMixin {
  bool _loading = false;
  DateTime startDateTime;
  String startTimeShow,startTimePost;
  String endTimeShow,endTimePost;
  String myPhone; //本人联系方式
  String emerPeople; //紧急联系人
  String emerPhone; //紧急联系人电话
  String destination; //请假去向
  String reason; //请假理由
  TabController mController;
  bool _agree = false;
  //销毁控制器
  @override
  void dispose() {
    super.dispose();
    mController.dispose();
    Global.qingjiaResultInfo = new QingjiaResultInfo();
  }

  void _qingjiaResultGet()async{
    await qingjiaResultGet(token: Global.token);
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    _qingjiaResultGet();
    //初始化控制器
    mController = TabController(
      length: 2,
      vsync: this,
    );
  }

  //提交请假申请
  void subApply() async {
    setState(() {
      _loading = true;
    });
    if (startTimePost != null &&
        endTimePost!= null &&
        myPhone != null &&
        emerPeople != null &&
        emerPhone != null &&
        destination != null &&
        reason != null) {
      await qingjiaPost(context, Global.token,startDate: startTimePost,
      endDate: endTimePost,
      reason: reason,
      myPhone: myPhone,
      emerPeople: emerPeople,
      emerPhone: emerPhone,
      destination: destination);
    }else{
      showToast(context, "请完善您的信息(X_X)");
    }
    setState(() {
      _loading = false;
    });
  }

  //新请假学生页面
  Widget _newLeaveStu() {
    return _agree == false
        ? Padding(
            padding: EdgeInsets.all(fontSizeNormal40 * 2),
            child: Wrap(
              runSpacing: fontSizeNormal40 * 3,
              children: <Widget>[
                Center(
                  child: Text(
                    '''请假须知：
        \n1.请如实填写请假外出时间、返校时间和请假事由，经辅导员老师批准后方可外出，研究生级导师同意后方可外出；
        \n2.请假外出期间要高度重视人身财物安全，避免发生意外事故，遵守地方疫情防控要求，做好个人防护''',
                    style: TextStyle(fontSize: fontSizeNormal40),
                  ),
                ),
                Center(
                  child: MyFlatButtonWithoutGradient('同意', onTap: () {
                    setState(() {
                      _agree = true;
                    });
                  }),
                )
              ],
            ),
          )
        : SingleChildScrollView(
            child: Wrap(
              runSpacing: fontSizeMini35 * 1.5,
              children: <Widget>[
                MyRowFlexButtonWithContent(
                    '开始时间',
                    startTimeShow == null
                        ? '点击选择开始时间'
                        : startTimeShow, onTap: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
                    setState(() {
                      startDateTime = date;
                      startTimeShow = formatDate(date, [yyyy, '-', mm, '-', dd,' ',HH,':',nn]);
                      startTimePost = formatDate(date, [yyyy, '-', mm, '-', dd,'T',HH,':',nn,':',ss]);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.zh);
                }),
                MyRowFlexButtonWithContent('结束时间',
                    endTimeShow == null ? '点击选择结束时间':endTimeShow,
                    onTap: () {
                  if(startTimeShow==null){
                    showToast(context,'请先选择开始时间');
                  }else{
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
                      if(startDateTime.isAfter(date)){
                        showToast(context, '结束时间应晚于开始时间(X_X)');
                      }else{
                        setState(() {
                          endTimeShow = formatDate(date, [yyyy, '-', mm, '-', dd,' ',HH,':',nn]);
                          endTimePost = formatDate(date, [yyyy, '-', mm, '-', dd,'T',HH,':',nn,':',ss]);
                        });
                      }
                        }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  }
                }),
                MyRowFlexButtonWithContent(
                    '本人联系方式', myPhone == null ? '点击输入' : myPhone,
                    onTap: () async {
                  myPhone = await MyInputDialogShow(context);
                  setState(() {});
                }),
                MyRowFlexButtonWithContent(
                    '紧急联系人', emerPeople == null ? '点击输入' : emerPeople,
                    onTap: () async {
                  emerPeople = await MyInputDialogShow(context);
                  setState(() {});
                }),
                MyRowFlexButtonWithContent(
                    '紧急联系人电话', emerPhone == null ? '点击输入' : emerPhone,
                    onTap: () async {
                  emerPhone = await MyInputDialogShow(context);
                  setState(() {});
                }),
                MyRowFlexButtonWithContent(
                    '请假去向', destination == null ? '点击输入' : destination,
                    onTap: () async {
                  destination = await MyInputDialogShow(context);
                  setState(() {});
                }),
                MyRowFlexButtonWithContent(
                    '请假理由', reason == null ? '点击输入' : reason, onTap: () async {
                  reason = await MyInputDialogShow(context, maxLines: 3);
                  setState(() {});
                }),
                Container(),
                Center(
                  child: _loading==false?Padding(
                    padding: EdgeInsets.fromLTRB(deviceWidth/3, 0, deviceWidth/3, 0),
                    child: MyFlatButtonWithoutGradient('提交',onTap: ()=>subApply()),
                  ):loadingAnimationIOS(),
                )
              ],
            ),
          );
  }

  //新请假老师页面
  Widget _newLeaveTea() {
    return Container();
  }






  //请假记录学生页面 0待审核 1批准 2拒绝
  int _index;
  Widget _leaveDialog(){
    _index = 1;
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: RefreshIndicator(
        onRefresh: ()async{
          await qingjiaResultGet(token: Global.token);
          setState(() {

          });
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Wrap(
            children: Global.qingjiaResultInfo.data.map((item){
              return Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.fromLTRB(fontSizeMini35*1.5, fontSizeMini35, fontSizeMini35*1.5, fontSizeMini35*0.5),
                    padding: EdgeInsets.all(fontSizeMini35*1.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("请假${_index++} : ",style: TextStyle(fontSize: fontSizeNormalTitle45,fontWeight: FontWeight.bold),),
                            Text(item.status==0?'待审核':item.status==1?'批准':'拒绝',style: TextStyle(fontSize: fontSizeNormal40,color: mainColor),)
                          ],
                        ),
                        Divider(height:fontSizeMini35*2,),
                        Text('''开始时间：${item.startDate}
              \n结束时间：${item.endDate}
              \n请假去向：${item.movement}
              \n请假原因：${item.reason}
              \n紧急联系人：${item.emergencyCaller}
              \n紧急联系人电话：${item.emergencyTel}
              \n审核人：${item.reviewerId}
              ''',style: TextStyle(fontSize: fontSizeMini35),),
                        Divider(),
                        Text("申请时间：${item.createTime}",style: TextStyle(fontSize: fontSizeMini35,color: Colors.black38),)
                      ],
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
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
                  text: "新请假",
                ),
                Tab(
                  text: "请假记录",
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
            _newLeaveStu(),
            Global.qingjiaResultInfo.data==null?Center(child: loadingAnimationIOS(),):Global.qingjiaResultInfo.data.isEmpty?
            MyFullScreenButton('无请假记录',onTap: ()async{
              await qingjiaResultGet(token: Global.token);
              setState(() {});
            }): _leaveDialog()
          ],
        ));
  }
}
