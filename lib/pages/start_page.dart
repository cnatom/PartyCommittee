
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_committee/NetRequest/swiper_get.dart';

//启动页,是进入App的第一个页面
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  void countDown() {
    var _duration = new Duration(seconds: 2);
    Future.delayed(_duration,
        ()=>Navigator.of(context).pushReplacementNamed('LoginPage'));
  }
  @override
  void initState() {
    swiperGet();
    super.initState();
    countDown();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          body: Container(
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3104841609,193700116&fm=26&gp=0.jpg'),
                  fit: BoxFit.cover
              ),
            ),
            child: OutlineButton(
                child: Text(
                  "跳过",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                shape: StadiumBorder(),
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed('LoginPage');
                }
            ),
          ),
        )
    );
  }
}
