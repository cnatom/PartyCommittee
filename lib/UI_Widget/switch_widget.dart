
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

//左右切换小组件
Widget switchWidget({ValueChanged<bool> onChanged,GestureTapCallback onTap,Text text,bool value}){
  return ListTile(
    title: text,
    trailing: CupertinoSwitch(
      activeColor: mainColor,
      value: value,
      onChanged: onChanged
    ),
    onTap: onTap
  );
}

//Widget switchWidget({ValueChanged<bool> onChanged}){
//  return ListTile(
//    title: Text("教职工登录"),
//    trailing: CupertinoSwitch(
//      activeColor: mainColor,
//      value: _light,
//      onChanged: (bool value){
//        setState(() {
//          _light = value;
//        });
//      },
//    ),
//    onTap: (){
//      setState(() {
//        _light = !_light;
//      });
//    },
//  );
//}
