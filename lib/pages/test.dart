import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:party_committee/DeviceData/device_data.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/appBar.dart';
import 'package:party_committee/UI_Widget/bezier_curve.dart';
import 'package:party_committee/UI_Widget/colors.dart';
import 'package:party_committee/pages/test_myself.dart';
import 'package:city_pickers/city_pickers.dart';
//跳转到当前页面
void toTestPage(BuildContext context) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => TestPage()));
//  Navigator.push(context,MaterialPageRoute(builder: (context)=>TestPage()));
}



class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController _controller1 = new TextEditingController();

  Result result;

  @override
  void initState() {
    super.initState();

  }

  Future<Null> _func()async{
    result = await CityPickers.showCityPicker(
      context: context,
    );
    setState(() {

    });
    print(result);

  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> sortItems = [];
    return Scaffold(
      appBar: MyAppBarWhite(context, "测试"),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            MyFlatButton("hello",onTap: ()=>_func()),
            Text(result.toString())
          ],
        ),
      ),
    );
  }
}
