
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