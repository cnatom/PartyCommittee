

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_committee/UI_Widget/colors.dart';

Widget AppBarWithBottom(BuildContext context,String title,{PreferredSizeWidget bottom}){
  return AppBar(
    backgroundColor: mainColor,
    title: Text(title),
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios,),
      onPressed: ()=>Navigator.pop(context),
    ),
    bottom: bottom,
  );
}

Widget whiteAppBar(BuildContext context,{String title}){
  return AppBar(
    brightness: Brightness.light,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text(title,style: TextStyle(color: Colors.black,fontSize: 18,),),
    elevation: 2,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
        size: 19,
      ),
      onPressed: ()=>Navigator.pop(context),
    ),
  );
}