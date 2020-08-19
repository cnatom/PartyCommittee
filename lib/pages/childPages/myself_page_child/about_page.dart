import 'package:flutter/material.dart';
import 'package:party_committee/animationEffect/custome_router.dart';


//跳转到当前页面
void toAboutPage(BuildContext context) {
  Navigator.of(context).push(CustomRoute(AboutPage(),milliseconds: 500));
}
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: LicensePage(
        applicationIcon: FlutterLogo(),
        applicationVersion: 'v0.0.1',
        applicationName: 'Flutter Unit',
        applicationLegalese: 'Copyright© 2018-2020 张风捷特烈',
      ),
    );
  }
}
