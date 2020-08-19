import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/appBar.dart';
import 'package:party_committee/UI_Widget/buttons.dart';
import 'package:party_committee/UI_Widget/colors.dart';

//跳转到当前页面
void toNullPage(BuildContext context) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => NullPage()));
//  Navigator.push(context,MaterialPageRoute(builder: (context)=>TestPage()));
}

class NullPage extends StatefulWidget {
  @override
  _NullPageState createState() => _NullPageState();
}

class _NullPageState extends State<NullPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246,246,246),
      appBar: MyAppBarWhite(context,'',),
      body: Center(
        child: Image.asset('images/null.png')),
    );
  }
}
