import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/animationEffect/custome_router.dart';
import 'package:party_committee/pages/childPages/diy_page_child/xiaoli_page.dart';
import 'package:photo_view/photo_view.dart';

import '../../login_page.dart';

//跳转到当前页面
void toXiaochePage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => XiaochePage()));
}

class XiaochePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: MyAppBarWhite(context, "校车"),
        body: Container(
            color: Colors.white,
            child: PhotoView(
              imageProvider: AssetImage("images/xiaoche_child.png"),
            )
        ),
      ),
    );
  }
}
