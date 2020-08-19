import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/bezier_curve.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/toast.dart';

//跳转到当前页面
void toXueshengPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => XueshengPage()));
//  Navigator.push(context,MaterialPageRoute(builder: (context)=>TestPage()));
}
class XueshengPage extends StatefulWidget {
  @override
  _XueshengPageState createState() =>
      _XueshengPageState();
}

class _XueshengPageState extends State<XueshengPage> {

  final TextEditingController _controller = new TextEditingController();
  String searchBarContent;

  void _searchFunc(){
    if(Global.admin==0){
      showToast(context, "暂不对学生用户开放搜索");
    }else{
      showToast(context, "暂未开放");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: MyAppBarColorful(context, '学生查询'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            clipWidget(80),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: <Widget>[
                      MySearchBar(_controller,hintText: "请输入姓名、拼音、学号、电话等信息"),
                      SizedBox(height: 20,),
                      MyFlatButton('搜索',onTap: ()=>_searchFunc())
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}