import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/NetClass/global.dart';
import 'package:party_committee/NetClass/searchStu_info.dart';
import 'package:party_committee/NetRequest/search_student_get.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/bezier_curve.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import 'package:party_committee/UI_Widget/toast.dart';
import 'package:party_committee/pages/childPages/diy_page_child/xueshengSearchChild_page.dart';

//跳转到当前页面
void toXueshengPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => XueshengPage()));
//  Navigator.push(context,MaterialPageRoute(builder: (context)=>TestPage()));
}

class XueshengPage extends StatefulWidget {
  @override
  _XueshengPageState createState() => _XueshengPageState();
}

class _XueshengPageState extends State<XueshengPage> {
  int _curPage;//当前页码
  int _pageSize=20;//当前页面的结果数
  final TextEditingController _textEditingController =
      new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool _loading;
  int page;
  void _searchFunc(int pageNum) async {
    setState(() {
      _loading = true;
    });
    if (Global.admin == 0) {
      Future.delayed(Duration(seconds: 1), () {
        showToast(context, "暂不对学生用户开放搜索(^_^)");
        setState(() {
          _loading = false;
        });
      });

    } else {
      if(_textEditingController.text.isEmpty){
        showToast(context, '搜索内容为空(X_X)');
        setState(() {
          _loading = false;
        });
      }else{
        await searchStuGet(
            aim: _textEditingController.text.toString(),
            curPageNum: pageNum,
            token: Global.token,
            pageSize: _pageSize);
        if (Global.searchStuInfo.data.pages=='0') {
          showToast(context, '查询无果(@_@)');
          setState(() {
            _loading = null;
          });
        }else{
          setState(() {
            _loading = false;
          });
        }
      }

    }
  }

  //输入框+搜索条区域
  Widget _searchArea() => Container(
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(20), ScreenUtil().setWidth(40), 0),
    padding: EdgeInsets.all(fontSizeNormal40),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50))),
        child: Column(
          children: <Widget>[
            MySearchBar(_textEditingController, hintText: "请输入姓名、拼音、学号、电话等信息"),
            SizedBox(
              height: fontSizeMini35,
            ),
            MyFlatButton('搜索', onTap: (){
              _curPage = 1;
              _searchFunc(_curPage);
              FocusScope.of(context).requestFocus(FocusNode());
            })
          ],
        ),
      );
  //标题：内容 组件
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

  //个人简介卡片按钮（搜索结果单项）
  Widget briefIntroCard(
          {String name,
          String department,
          String grade,
          String classes,
          String id}) =>
      Container(
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), 0, ScreenUtil().setWidth(40), ScreenUtil().setWidth(30)),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
          child: InkWell(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
            onTap: () =>toXueshengChildPage(context, id),//切换到个人页面
            child: Container(
              padding: EdgeInsets.all(fontSizeMini35),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50))),
              child: Column(
                children: <Widget>[
                  //顶端bar
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.black45,
                              size: fontSizeNormal40,
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(25),
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: fontSizeNormal40,
                                color: Color.fromARGB(255, 16, 28, 81),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.black38,
                          size: fontSizeNormal40*1.3,
                        )
                      ],
                    ),
                  ),
                  //分割线
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(20)),
                    child: Container(
                      height: 0.1,
                      color: mainColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _rowContent('学院', department),
                      _rowContent('学号', id),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _rowContent('班级', classes),
                      _rowContent('年级', grade),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  //查询结果列表
  Widget _searchResultArea() {
    return Column(
      children: Global.searchStuInfo.data == null
          ? [Container()]
          : Global.searchStuInfo.data.records.map((item) {
              return briefIntroCard(
                  name: item.name,
                  department: item.department,
                  grade: item.grade,
                  classes: item.classes,
                  id: item.id);
            }).toList(),
    );
  }

  //切换页码区域
  Widget _switchPageArea() {
    return Global.searchStuInfo.data == null
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  if(_curPage>1){
                    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                    _searchFunc(--_curPage);
                  }else{
                    showToast(context, '已经到首页了(~_~)');
                  }
                },
                child: Text("上一页",style: TextStyle(fontSize: fontSizeMini35)),
              ),
              Text(
                  "${Global.searchStuInfo.data.current}/${Global.searchStuInfo.data.pages}",style: TextStyle(fontSize: fontSizeNormal40)),
              FlatButton(
                onPressed: () {
                  if(_curPage<int.parse(Global.searchStuInfo.data.pages)){
                    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                    _searchFunc(++_curPage);
                  }else{
                    showToast(context, '已经到尾页了(O_O)');
                  }
                },
                child: Text("下一页",style: TextStyle(fontSize: fontSizeMini35),),
              ),
            ],
          );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          backgroundColor: Colors.white,
          onPressed: () {
            _scrollController.jumpTo(_scrollController.position.minScrollExtent);
          },
          child: Icon(
            Icons.keyboard_arrow_up,
            color: mainColor,
          ),
        ),
        backgroundColor: pageBackgroundColor,
        appBar: MyAppBarColorful(context, '学生查询',),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                child: Container(
                  height: ScreenUtil().setWidth(200),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [mainColor, mainColor.withAlpha(200)])),
                ),
              ),
              Column(
                children: <Widget>[
                  _searchArea(),

                  //搜索结果卡片
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
                      : Column(
                    children: <Widget>[
                      _switchPageArea(),
                      _searchResultArea(),
                      SizedBox(
                        height: ScreenUtil().setWidth(50),
                      ),
                      _switchPageArea(),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    Global.searchStuInfo = new SearchStuInfo();
  }
}
