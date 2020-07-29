//第二个课表页

import 'package:flutter/cupertino.dart';
import 'package:party_committee/NetClass/global.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Widget build(BuildContext context) {
    return Center(
      child: Text(Global.swiperInfo.data[0].imgUrl),
    );
  }
}
