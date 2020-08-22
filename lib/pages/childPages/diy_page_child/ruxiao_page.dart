import 'dart:convert';
import 'dart:ffi';

import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/passPdf_info.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:party_committee/pages/childPages/diy_page_child/ruxiao_page_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

//跳转到当前页面
void toRuxiaoPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => RuxiaoPage()));
//  Navigator.push(context,MaterialPageRoute(builder: (context)=>TestPage()));
}

//出行方式
class ChuXing {
  Map data;
}

class RuxiaoPage extends StatefulWidget {
  @override
  _RuxiaoPageState createState() => _RuxiaoPageState();
}

class _RuxiaoPageState extends State<RuxiaoPage> {
  TextStyle _itemTitleStyle =
      TextStyle(fontSize: 15, color: Color.fromARGB(255, 139, 143, 155));
  TextStyle _itemContentStyle = TextStyle(fontSize: 15);
  Icon _rightArrowIcon = Icon(
    Icons.chevron_right,
    color: Colors.black.withAlpha(150),
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _position;
  List<int> transitIndexList = new List<int>();
  //基本信息
  Result juzhuResult; //居住地
  TextEditingController juzhuController = new TextEditingController(); //具体居住地
  TextEditingController jinjirenController =
      new TextEditingController(); //紧急联系人
  TextEditingController jinjidianController =
      new TextEditingController(); //紧急联系人电话

  //申请内容
  String daoxiao; //到校日期
  Result chufaResult; //居住地
  TextEditingController shuoming1Controller =
      new TextEditingController(); //第一个需要说明的内容
  String jihua; //计划出行时间

  //个人行程
  List<TextEditingController> qishiController =
      new List<TextEditingController>(); //起始站点
  List<TextEditingController> chepaiController =
      new List<TextEditingController>(); //车牌号/车次
  List<TextEditingController> zuoweiController =
      new List<TextEditingController>(); //座位号
  List<TextEditingController> mubiaoController =
      new List<TextEditingController>(); //目标站点

  String dixuTime; //抵徐时间
  int dixuHour = -1; //抵徐小时
  String dixuAddress; //抵徐地点
  TextEditingController peitongController = new TextEditingController(); //陪同人员
  Map questions = {'q1': true, 'q2': true, 'q3': true, 'q4': true};
  TextEditingController benrenController = new TextEditingController(); //本人签名
  TextEditingController jianhuController = new TextEditingController(); //监护人签名

  //输入框组件
  Widget MyInputBarFlex(TextEditingController controller,
          {String hintText = "请输入",
          double borderRadius = 30,
          int maxLines = 1}) =>
      Container(
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 0.5),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: TextField(
          maxLines: maxLines,
          controller: controller,
          style: TextStyle(color: mainTextColor),
          decoration:
              InputDecoration(border: InputBorder.none, hintText: hintText),
        ),
      );

  //水平选择布局（出行方式）
  List<String> chuxing = new List<String>(5); //出行方式
  Widget _chuxingChose(String title, int index) {
    int curIndex = index - 1;
    String curValue = chuxing[curIndex];
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: MyTitleItem(title),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            height: 45,
            width: 200,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 0.5),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30)),
            child: DropdownButton(
                isExpanded: true,
                hint: Text("请选择"),
                underline: Container(),
                value: curValue,
                items: fangshi.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  chuxing[curIndex] = v;
                  curValue = v;
                  setState(() {
                    print(curValue);
                  });
                }),
          )
        ],
      ),
    );
  }

  //水平选择布局（抵徐地点）
  String dixuCurValue;
  Widget _dixuChose(
    String title,
    List infoList,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: MyTitleItem(title),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            height: 45,
            width: 200,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 0.5),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30)),
            child: DropdownButton(
                isExpanded: true,
                hint: Text("请选择"),
                underline: Container(),
                value: dixuCurValue,
                items: infoList.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                    ),
                  );
                }).toList(),
                onChanged: (v) => setState(() {
                      dixuAddress = v;
                      dixuCurValue = v;
                    })),
          )
        ],
      ),
    );
  }

  //水平输入布局
  Widget _rowInputItem(String title, TextEditingController controller,
      {String hintText = '请输入'}) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: MyTitleItem(title),
          ),
          Container(
            width: 200,
            child: MyInputBarFlex(controller, hintText: hintText),
          )
        ],
      ),
    );
  }

  //标题组件
  Widget MyTitleItem(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 15, color: mainTextColor),
    );
  }

  //步标题组件
  Widget MyTitleStep(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 21, color: mainTextColor, fontWeight: FontWeight.bold),
    );
  }

  //竖直分布卡片
  Widget _columnCard({List<Widget> children = const <Widget>[]}) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Wrap(
        runSpacing: 20,
        children: children,
      ),
    );
  }

//长条式卡片按钮(有内容)
  Widget _rowFlexButtonWithContent(String title, String content,
      {GestureTapCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          //信息列表
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: _itemTitleStyle,
                    ),
                    Text(
                      content,
                      maxLines: 100,
                      style: _itemContentStyle,
                    )
                  ],
                ),
              ),
              _rightArrowIcon
            ],
          ),
        ),
      ),
    );
  }

  //增加/删除中转 按钮
  Widget MyLittleButton(String title,
      {GestureTapCallback onTap, Color color = Colors.redAccent}) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _checkQuestion(String question, String aim) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            question,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    value: questions[aim],
                    onChanged: (v) => setState(() {
                      questions[aim] = v;
                    }),
                  ),
                  Text("是"),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: !questions[aim],
                    onChanged: (v) => setState(() {
                      questions[aim] = !v;
                    }),
                  ),
                  Text("否"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> _juzhuDatePickers() async {
    juzhuResult = await CityPickers.showCityPicker(
      context: context,
    );
    setState(() {});
  }

  Future<Null> _chufaDatePickers() async {
    chufaResult = await CityPickers.showCityPicker(
      context: context,
    );
    setState(() {});
  }

  void _daoxiaoDataPicker() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2020, 8, 1),
        maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
      setState(() {
        daoxiao =
            "${date.year.toString()}年${date.month.toString()}月${date.day.toString()}日";
      });
    }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }

  void _jihuaDataPicker() {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2020, 8, 1),
        maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
      setState(() {
        jihua =
            "${date.year.toString()}年${date.month.toString()}月${date.day.toString()}日 ${date.hour.toString()}:${date.minute.toString()}";
      });
    }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }

  void _dixuDataPicker() {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2020, 8, 1),
        maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
      setState(() {
        dixuHour = date.hour;
        dixuTime =
            "${date.year.toString()}年${date.month.toString()}月${date.day.toString()}日 ${date.hour.toString()}:${date.minute.toString()}";
      });
    }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }

  //获取审核步骤信息
  int subResult = 0;//管理员审核结果 0-审核中 1-审核未通过
  void _passInfoGet() async {
    final token = (await SharedPreferences.getInstance()).getString('token');
    try {
      Response res;
      Dio dio = Dio();
      //配置dio信息
      res = await dio.get("https://xyt-wx.cumt.edu.cn/api/backSchools/passInfo",
          options: Options(headers: {"Authorization": token}));
      debugPrint(res.toString());
      //Json解码为Map
      Map<String, dynamic> map = jsonDecode(res.toString());
      if(map['code']==0){
        if (map['data'] == '未填写') {
          _position = 0;
        } else if (map['data'] == '未审核') {
          subResult = 0;
          _position = 1;
        } else if(map['data'] == '审核未通过'){
          subResult = 1;
          _position = 1;
        }else if (map['data'] == '审核通过') {
          _passPdfInfoGet();
          _position = 2;
        }
        setState(() {});
      }
    } catch (e) {
      _position=null;
      setState(() {
      });
      showToast(context, '请求失败，请检查您的网络连接(X_X)');
    }
  }

  //获取审核通过的Pdf信息
  void _passPdfInfoGet() async {
    final token = (await SharedPreferences.getInstance()).getString('token');
    try {
      Response res;
      Dio dio = Dio();
      //配置dio信息
      res = await dio.get(
          "https://xyt-wx.cumt.edu.cn/api/backSchools/passInfoPdf",
          options: Options(headers: {"Authorization": token}));
      debugPrint(res.toString());
      //Json解码为Map
      Map<String, dynamic> map = jsonDecode(res.toString());
      Global.passPdfInfo = PassPdfInfo.fromJson(map);
      setState(() {});
    } catch (e) {
      showToast(context, "访问失败(X_X)");
      print(e.toString());
    }
  }

  //初始化中转行程数据
  @override
  void initState() {
    if(Global.admin==0){
      _passInfoGet();
      print(_position.toString());
      super.initState();
      for (int i = 0; i < 6; i++) {
        qishiController.add(new TextEditingController());
        chepaiController.add(new TextEditingController());
        zuoweiController.add(new TextEditingController());
        mubiaoController.add(new TextEditingController());
      }
      transitIndexList.add(1);
    }
  }

  //提交申请
  void _submitFunc() async {
    //检测行程列表
    for (int i = 1; i <= transitIndexList.length; i++) {
      if (qishiController[i].text.isEmpty ||
          chuxing[i - 1].isEmpty ||
          chepaiController[i].text.isEmpty ||
          zuoweiController[i].text.isEmpty ||
          mubiaoController[i].text.isEmpty) {
        showToast(context, '请完善您的信息(X_X)');
        print(qishiController[0].text);
        return;
      }
    }

    if (juzhuResult == null || //居住地
            juzhuController.text.isEmpty || //详细居住地
            jinjirenController.text.isEmpty || //紧急联系人
            jinjidianController.text.isEmpty || //紧急联系人电话
            //申请内容
            daoxiao.isEmpty || //到校日期
            chufaResult == null || //出发地
            //个人行程
            jihua.isEmpty || //计划出行时间
//        chuxing.data['dixu'] == null ||//抵徐地点
            dixuHour == -1 || //抵徐时间（只取小时）
            dixuAddress.isEmpty || //抵徐地点
            peitongController.text.isEmpty || //陪同人员
            benrenController.text.isEmpty || //本人签字（无用）
            jianhuController.text.isEmpty //监护人签字
        ) {
      showToast(context, "请完善您的信息(X_X)");
    } else {
      //基本信息
      subData['stuNum'] = Global.id; //学号
      subData['address'] = //居住地
          "${juzhuResult.provinceName}-${juzhuResult.cityName}-${juzhuResult.areaName}-${juzhuController.text}";
      subData['emergencyCallee'] = jinjirenController.text; //紧急联系人
      subData['emergencyPhone'] = jinjidianController.text; //紧急联系人方式
      //申请内容
      subData['date'] = daoxiao; //到校日期
      subData['loc'] = //出发地
          "${chufaResult.provinceName}-${chufaResult.cityName}-${chufaResult.areaName}";
      subData['reason'] = //其他需要说明的内容
          shuoming1Controller.text.isEmpty ? '' : shuoming1Controller.text;
      //个人行程
      subData['note'] = "本人计划 ${jihua} ,";
      for (int i = 1; i <= transitIndexList.length; i++) {
        subData['note'] +=
            "\n(路线${i}) 由 ${qishiController[i].text} 乘坐 ${chuxing[i - 1]} "
            "到 ${mubiaoController[i].text}。"
            "车牌号/车次：${chepaiController[i].text}，"
            "座位号：${zuoweiController[i].text}。";
      }
      subData['note'] +=
          "\n于 ${dixuTime} 抵徐，抵徐地点：${dixuAddress}，陪同人员：${peitongController.text}";
      subData['hour'] = dixuHour; //抵徐时间（只取小时）
      subData['pickupLoc'] = dixuAddress; //抵徐地点
      subData['company'] = peitongController.text; //陪同人员
      subData['q1'] = questions['q1'] == true ? 1 : 0;
      subData['q2'] = questions['q2'] == true ? 1 : 0;
      subData['q3'] = questions['q3'] == true ? 1 : 0;
      subData['q4'] = questions['q4'] == true ? 1 : 0;

      subData['guardian'] = jianhuController.text;
      //发送网络请求
      Response res;
      Dio dio = Dio();
      final token = (await SharedPreferences.getInstance()).getString('token');
      try {
        //配置dio信息
        res = await dio.post('https://xyt-wx.cumt.edu.cn/api/backSchools',
            data: subData, options: Options(headers: {'Authorization': token}));
        debugPrint(res.toString());
        Map<String, dynamic> map = jsonDecode(res.toString());
        if (map['code'] == 0) {
          showToast(context, "提交成功");
          setState(() {
            if(_position==0){
              subResult=0;
              _position++;
            }

          });
        } else {
          showToast(context, '提交失败');
        }
      } catch (e) {
        debugPrint(subData.toString());
        showToast(context, '提交失败');
      }
    }
  }

  //删除个人返校数据
  void _delpassInfo() async {
    final token = (await SharedPreferences.getInstance()).getString('token');
    try {
      Response res;
      Dio dio = Dio();
      //配置dio信息
      res = await dio.post("https://xyt-wx.cumt.edu.cn/api/backSchools/delete",
          options: Options(headers: {"Authorization": token}));
      debugPrint(res.toString());
      //Json解码为Map
      Map<String, dynamic> map = jsonDecode(res.toString());
      if (map['code'] == 0) {
        showToast(context, "成功取消申请！");
        _position--;
      } else {
        showToast(context, "请求失败");
      }
      setState(() {});
    } catch (e) {
      showToast(context, "未知错误");
      print(e.toString());
    }
  }

  //添加中转行程
  void _addTransitItem() {
    int index = transitIndexList.length;
    if (transitIndexList.length < 5) {
      setState(() {
        transitIndexList.add(index + 1);
      });
    } else {
      showToast(context, "到达上限");
    }
  }

  //删除中转行程
  void _delTransitItem() {
    if (transitIndexList.length > 1) {
      setState(() {
        transitIndexList.removeLast();
      });
    } else {
      showToast(context, "再删就没了(>_<)");
    }
  }

  Map subData = {
    'stuNum': Global.id, //学号

    'address': '', //居住地
    'emergencyCallee': '', //紧急联系人
    'emergencyPhone': '', //紧急联系电话
    //申请内容
    'date': '', //到校日期
    'loc': '', //出发地
    'reason': '', //请描述必要的返校原因
    //个人行程
    'note': '', //个人行程
    'hour': 23, //抵徐时间(小时)
    'pickupLoc': '', //抵徐地点

    'company': '', //陪同人员
    'pass': 0, //是否批准  （0没批 1拒绝 2批准）
    'q1': 0, //近两周是否接触过有发热或呼吸道感染症状的人员(0没接触 1接触过)
    'q2': 0, //近两周是否有境外旅居史(0没接触 1接触过)
    'q3': 0, //近两周是否接触过境外归国人员  (0没接触 1接触过)
    'q4': 0, //近两周是否有发热、干咳、乏力等症状(0没接触 1接触过)
    'reviewedBy': '', //审核人
    'guardian': '', //家长监护人姓名
  };

  //重新提交信息
  //长篇文章
  Widget _article(String text,
      {Color color = Colors.black, FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: color, fontWeight: fontWeight),
      ),
    );
  }

  //加载页
  Widget loadingPage() => Scaffold(
        appBar: MyAppBarWhite(context, '入校申请'),
        body: Center(
          child: loadingAnimation,
        ),
      );
  //教职工页
  Widget teacherRuxiaoPage() => Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        appBar: MyAppBarWhite(
          context,
          '入校申请',
        ),
        body: Center(child: Image.asset('images/ruxiao_null.png')),
      );
  //第一步
  Widget firstStep1() => GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Wrap(
        runSpacing: 20,
        children: <Widget>[
//            MyTitleStep('第一步：完善基本信息'),
          _columnCard(children: [
            _rowFlexButtonWithContent(
                '居住地',
                juzhuResult == null
                    ? "点击选择居住地"
                    : '${juzhuResult.provinceName}-${juzhuResult.cityName}-${juzhuResult.areaName}',
                onTap: () => _juzhuDatePickers()),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:
                  MyInputBarFlex(juzhuController, hintText: "请填写街道/小区/村、门牌号等"),
            ),
            _rowInputItem('紧急联系人', jinjirenController),
            _rowInputItem('紧急联系人电话', jinjidianController),
          ]),
          _columnCard(children: [
            _rowFlexButtonWithContent(
                '到校日期', daoxiao == null ? "点击选择到校日期" : daoxiao,
                onTap: () => _daoxiaoDataPicker()),
            _rowFlexButtonWithContent(
                '出发地',
                chufaResult == null
                    ? "点击选择出发地"
                    : '${chufaResult.provinceName}-${chufaResult.cityName}-${chufaResult.areaName}',
                onTap: () => _chufaDatePickers()),
            _article("       本人已经知晓和同意学校学校有关疫情防控期间开学返校的要求、内容和程序，现在根据有关内容，"
                "特向学院申请返校。期间按照学校要求，提前告知学院行程，做好个人防护，注意旅途安全，配合学校做好开学返校工作。"),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: MyInputBarFlex(
                shuoming1Controller,
                hintText: "其他需要说明的内容(请描述必要的返校内容)",
                maxLines: 5,
                borderRadius: 10,
              ),
            ),
          ]),
          //个人行程
          _columnCard(children: [
            _rowFlexButtonWithContent(
                '计划出行时间', jihua == null ? "点击选择计划出行具体时间" : jihua,
                onTap: () => _jihuaDataPicker()),
            //中转
            Wrap(
              runSpacing: 20,
              children: transitIndexList.map((index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Wrap(
                    runSpacing: 20,
                    children: <Widget>[
                      Divider(),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "路线 - ${index}",
                          style: TextStyle(fontSize: 18, color: Colors.black38),
                        ),
                      ),
                      _rowInputItem('起始站点', qishiController[index],
                          hintText: "如：潍坊站"),
                      _rowInputItem('目标站点', mubiaoController[index]),
                      _chuxingChose('出行方式', index),
                      _rowInputItem('车牌号/车次', chepaiController[index],
                          hintText: "如：Z168"),
                      _rowInputItem('座位号', zuoweiController[index],
                          hintText: "如：5车14座或无(自驾)"),
                    ],
                  ),
                );
              }).toList(),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: MyLittleButton('+增加中转行程',
                        color: mainColor.withAlpha(230),
                        onTap: () => _addTransitItem()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyLittleButton('删除', onTap: () => _delTransitItem()),
                  )
                ],
              ),
            ),
            Divider(),
            _rowFlexButtonWithContent(
                '抵徐时间', dixuTime == null ? "点击选择抵达徐州的时间" : dixuTime,
                onTap: () => _dixuDataPicker()),
            _dixuChose("抵徐地点", zhandian),
            _rowInputItem('陪同人员', peitongController),
          ]),
          _columnCard(children: [
            _checkQuestion("近两周是否接触过有发热或呼吸道感染症状的人员？", 'q1'),
            _checkQuestion("近两周是否有境外旅居史？", 'q2'),
            _checkQuestion("近两周是否有接触境外归国人员？", 'q3'),
            _checkQuestion("近两周是否有发热、干咳、乏力等症状？", 'q4'),
          ]),
          _columnCard(children: [
            _article('        本人已经知晓学校制定的有关疫情防控工作内容，本人现在居住地降为'
                '低风险地区已满一个月，符合出行条件。本人目前身体健康，无发烧、咳嗽等症状。'
                '本人目前不在疫情防控中、高风险地区，14天内也未在疫情防控中、高风险地区停留旅居，'
                '14天内未与从疫情防控中、高风险地区返乡人员密切接触，14天内未有境外旅居史和与'
                '境外归国人员密切接触史。没有向学校隐瞒其他内容。\n'
                '       如弄虚作假或隐瞒不报等带来的后果由本人承担。'),
            _article('输入姓名将用于生成电子签名，表明您已阅读并承诺以上内容',
                color: Colors.red, fontWeight: FontWeight.bold),
            _rowInputItem('本人签字', benrenController),
            _rowInputItem('家长（监护人）签字', jianhuController),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: MyFlatButton('提交申请', onTap: () => _submitFunc()),
            )
          ])
        ],
      ));
  //第二步
  Widget firstStep2() => Container(
        child: Column(
          children: <Widget>[
            //等待管理员审核
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor.withAlpha(10),
                        spreadRadius: 0.1,
                        blurRadius: 10)
                  ]),
              padding: EdgeInsets.all(20),
              child: subResult==0?Row(
                children: <Widget>[
                  CupertinoActivityIndicator(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "等待管理员审核......",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ):Row(
                children: <Widget>[
                  Icon(Icons.do_not_disturb),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "审核未通过，请重新提交",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            MyLittleButton('重新提交信息', onTap: () => _delpassInfo())
          ],
        ),
      );
  //第三步
  Widget firstStep3() => Global.passPdfInfo.data == null
      ? Center(
          child: loadingAnimation,
        )
      : Container(
          height: 1200,
          child: Column(
            children: <Widget>[
              //您的申请已通过！
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: shadowColor.withAlpha(10),
                          spreadRadius: 0.1,
                          blurRadius: 10)
                    ]),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.done),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "您的申请已通过！",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: shadowColor.withAlpha(10),
                              spreadRadius: 0.1,
                              blurRadius: 10)
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.asset(
                            'images/cumtwater.png',
                            repeat: ImageRepeat.repeat,
                            cacheHeight: 100,
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "返校通知书",
                                      style: TextStyle(
                                          fontSize: 22,
                                          letterSpacing: 5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  Global.passPdfInfo.data.name + '  同学：',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                _article(
                                    '        请你持学生本人校园卡/学生证以及本通知书按规定时间和地点返校，办理有关返校手续。'),
                                _article('入校时间：' + Global.passPdfInfo.data.date,
                                    fontWeight: FontWeight.bold),
                                _article('抵徐地点：' + Global.passPdfInfo.data.loc,
                                    fontWeight: FontWeight.bold),
                                _article(
                                    '审核人：' + Global.passPdfInfo.data.reviewedBy,
                                    fontWeight: FontWeight.bold),
                                _article(
                                    '        温馨提示：返校途中注意人身安全，全程做好防护措施。返校当日学校在火车站、高铁站设有接站点，'
                                    '请主动出示个人相关材料，配合做好体温监测等程序。到校后，遵守国家法律法规和学校规章制度，做好每日晨检、午检等，'
                                    '配合学校做好疫情防控工作。'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '本人承诺：',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                _article(
                                    '        本人已经知晓学校制定的有关疫情防控工作内容。本人现在居住地降为低风险地区已满一个月，符合出行条件。'
                                    '本人目前身体健康，无发烧、咳嗽等症状。本人目前不在疫情防控中、高风险地区，14天内也未在疫情防控中、高风险地区停留旅居，'
                                    '14天内未与从疫情防控中、高风险地区返乡人员密切接触，14天内未有境外旅居史和与境外归国人员密切接触史。'
                                    '没有向学校隐瞒其他内容。\n       如弄虚作假或隐瞒不报等带来的后果由本人承担。'),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "学生签名：",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(Global.passPdfInfo.data.name,
                                        style: GoogleFonts.maShanZheng(
                                            fontSize: 25)),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "家长(监护人)签名：",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        Global.passPdfInfo.data.emergencyCallee,
                                        style: GoogleFonts.maShanZheng(
                                            fontSize: 25)),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    _article('中国矿业大学',
                                        fontWeight: FontWeight.bold)
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Opacity(
                                      opacity: 0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "黑天鹅互联网工作室",
                                            style: TextStyle(letterSpacing: 2),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Image.asset(
                                            'images/batswan.jpg',
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Global.admin!=0
        ? teacherRuxiaoPage()
        : _position==null
        ?loadingPage() : Scaffold(
                key: _scaffoldKey,
                backgroundColor: pageBackgroundColor,
                appBar: MyAppBarWhite(context, "入校申请"),
                body: Container(
                  child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: _position,
                      controlsBuilder: (_,
                          {VoidCallback onStepContinue,
                          VoidCallback onStepCancel}) {
                        return Container();
                      },
                      steps: [
                        Step(
                          isActive: _position == 0 ? true : false,
                          title: Text("提交申请"),
                          content: Container(child: firstStep1()),
                        ),
                        Step(
                            isActive: _position == 1 ? true : false,
                            title: Text("等待审核"),
                            content: firstStep2()),
                        Step(
                            isActive: _position == 2 ? true : false,
                            title: Text("审核通过"),
                            content: firstStep3()),
                      ]),
                ),
              );
  }

  @override
  void dispose() {
    super.dispose();
    qishiController.clear();
    chepaiController.clear();
    zuoweiController.clear();
    mubiaoController.clear();
    juzhuController.dispose();
    jinjidianController.dispose();
    jinjirenController.dispose();
    shuoming1Controller.dispose();
  }
}
