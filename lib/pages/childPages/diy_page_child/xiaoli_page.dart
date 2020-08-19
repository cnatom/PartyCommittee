import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:photo_view/photo_view.dart';

import '../../login_page.dart';

//跳转到当前页面
void toXiaoliPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => XiaoliPage()));
}

class XiaoliPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: MyAppBarWhite(context, "校历"),
        body: Container(
            child: PhotoView(
              imageProvider: AssetImage("images/xiaoli_child.png"),
            )
        ),
      ),
    );
  }
}
