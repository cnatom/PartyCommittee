

//跳转到当前页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';

void toYinsiPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => YinsiPage()));
}


class YinsiPage extends StatelessWidget {
  Widget _articleBold(String text)=>Text(text,style: TextStyle(fontSize: fontSizeNormal40,fontWeight: FontWeight.w600),);
  Widget _articleNormal(String text)=>Text(text,style: TextStyle(fontSize: fontSizeNormal40),);
  String text1 = '本应用非常重视用户隐私政策并严格遵守相关的法律规定。请您仔细阅读《隐私政策》后再继续使用。如果您继续使用我们的服务，表示您已经充分阅读和理解我们协议的全部内容。';
  String text2 = '本app尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更优质的服务，本应用会按照本隐私权政策的规定使用和披露您的个人信息。'
      '除本隐私权政策另有规定外，在未征得您事先许可的情况下，本应用不会将这些信息对外披露或向第三方提供。'
      '本应用会不时更新本隐私权政策。 您在同意本应用服务使用协议之时，即视为您已经同意本隐私权政策全部内容。';
  String text1a = '(a)在您使用本应用网络服务，或访问本应用平台网页时，本应用自动接收并记录的您设备上的信息，'
      '包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；';
  String text1b = '(b)本应用通过合法途径从合作伙伴处取得的用户个人数据。';
  String text2a = '(a)本应用不会向任何无关第三方提供、出售、出租、分享或交易您的个人登录信息。';
  String text2b = '(b) 为服务用户的目的，本应用可能通过使用您的个人信息，以提供查询等服务。';
  String text30 = '在如下情况下，本应用将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：';
  String text3a = '(a) 未经您事先同意，我们不会向第三方披露；';
  String text3b = '(b) 为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；';
  String text3c = '(c) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；';
  String text4a = '(a)如果决定更改隐私政策，我们会在本政策中以及我们认为适当的位置发布这些更改，'
      '以便您了解我们如何收集、使用您的个人信息，哪些人可以访问这些信息，以及在什么情况下我们会透露这些信息。';
  String textSum = '请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，'
      '尤其是本应用用户名及密码发生泄露，请您立即联络本应用开发人员，以便本应用采取相应措施。感谢您花时间了解我们的隐私政策！'
      '我们将尽全力保护您的个人信息和合法权益，再次感谢您的信任！';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWhite(context, '隐私政策'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Wrap(
            runSpacing: ScreenUtil().setHeight(40),
            children: <Widget>[
              Center(
                child:Text("矿大校园通隐私政策",textAlign: TextAlign.center,style: TextStyle(fontSize: fontSizeNormalTitle45,fontWeight: FontWeight.w900),) ,
              ),
              _articleBold(text1),
              _articleBold(text2),
              _articleBold('1. 适用范围'),
              _articleNormal(text1a),
              _articleNormal(text1b),
              _articleBold('2. 信息使用'),
              _articleNormal(text2a),
              _articleNormal(text2b),
              _articleBold('3. 信息披露'),
              _articleNormal(text30),
              _articleNormal(text3a),
              _articleNormal(text3b),
              _articleNormal(text3c),
              _articleBold('4.本隐私政策的更改'),
              _articleNormal(text4a),
              _articleBold(textSum),
              Container(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
