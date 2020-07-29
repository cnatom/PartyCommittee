import 'package:flutter/material.dart';
import 'package:party_committee/pages/childPages/course_page.dart';
import 'package:party_committee/pages/childPages/myself_page.dart';
import 'UI_Widget/colors.dart';
import 'file:///C:/Users/jinte/Desktop/B@SwanStudio/PartyCommittee/party_committee/lib/pages/childPages/home_page.dart';
import 'package:party_committee/pages/login_page.dart';
import 'package:party_committee/pages/navigator_page.dart';
import 'package:party_committee/pages/start_page.dart';

void main()=>runApp(
  MaterialApp(
    theme: ThemeData(
        primaryColor: mainColor,
        accentColor: mainColor
    ),
    debugShowCheckedModeBanner: false,
    routes: <String,WidgetBuilder>{
      'NavigatorPage':(BuildContext context)=>NavigatorPage(),
      'LoginPage': (BuildContext context)=>LoginPage(),
      'HomePage':(BuildContext context)=>HomePage(),
      'CoursePage':(BuildContext context)=>CoursePage(),
      'MyselfPage':(BuildContext context)=>MyselfPage()
    },
    home: StartPage(),
  )
);