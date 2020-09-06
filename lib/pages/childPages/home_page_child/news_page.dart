import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/appBar.dart';
import 'package:party_committee/UI_Widget/colors.dart';

//跳转到当前页面
void toNewsPage(BuildContext context,String title,List<String> content,String time) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => NewsPage(title,content,time)));
//  Navigator.push(context,MaterialPageRoute(builder: (context)=>TestPage()));
}

class NewsPage extends StatefulWidget {
  String title;
  List<String> content;
  String time;
  NewsPage(this.title,this.content,this.time);
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: MyAppBarWhite(context, "文章详情"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10,),
                //标题前竖线
                Container(
                  color: mainColor,

                  width: ScreenUtil().setWidth(8),
                  height: ScreenUtil().setSp(140),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(widget.title,overflow:TextOverflow.ellipsis,maxLines: 3,style: TextStyle(fontSize: fontSizeNormalTitle45,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Text(widget.time,style: TextStyle(color:Colors.black45,fontSize: fontSizeNormal40),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                      childAnimationBuilder: (widget) => SlideAnimation(
                        duration: Duration(milliseconds: 500),
                        delay: Duration(milliseconds: 100),
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          delay: Duration(milliseconds: 200),
                          duration: Duration(milliseconds: 500),
                          child: widget,
                        ),
                      ),
                      children: widget.content.map((e) => Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Text("　　"+e,style: TextStyle(fontSize: fontSizeNormal40,height: 2),),
                      )).toList()
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
