import 'package:flui/flui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

Widget mainButton({VoidCallback onPressed,Text text}){
  return FLLoadingButton(
      child: text,
      color: mainColor,
      indicatorColor: Colors.white,
      textColor: Colors.white,
      minWidth: 200,
      indicatorOnly: true,
      onPressed: onPressed
  );
}