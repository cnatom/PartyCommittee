

//跳转到当前页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party_committee/UI_Widget/MyUiWidgets.dart';
import 'package:party_committee/UI_Widget/colors.dart';

void toYonghuPage(BuildContext context) {
  Navigator.push(
      context, CupertinoPageRoute(builder: (context) => YonghuPage()));
}


class YonghuPage extends StatelessWidget {
  Widget _articleBold(String text)=>Text(text,style: TextStyle(fontSize: fontSizeNormal40,fontWeight: FontWeight.w600),);
  Widget _articleNormal(String text)=>Text(text,style: TextStyle(fontSize: fontSizeNormal40),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWhite(context, '用户协议'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Wrap(
            runSpacing: ScreenUtil().setHeight(40),
            children: <Widget>[
              Center(
                child:Text("矿大校园通用户协议",textAlign: TextAlign.center,style: TextStyle(fontSize: fontSizeNormalTitle45,fontWeight: FontWeight.w900),) ,
              ),
              _articleNormal('''生效日期：2020年9月1日
              \n【提示条款】欢迎您使用矿大校园通(以下简称“校园通”)！
              \n【审慎阅读】请您务必审慎阅读、充分理解各条款的内容，特别是免除或者限制责任的条款、争议解决和法律适用条款等。
              \n【签约动作】当您在登录页点击同意并登陆账号，即表示您已充分阅读、理解并接受本协议的全部内容，成为校园通用户。
              \n本协议可能会不定时进行更新，如果您不同意本协议的任何内容（包括更新后的内容），您应立即停止使用。否则，您的使用及任何操作行为，均视为已接受本协议约束。'''),
              _articleBold('一、适用范围'),
              _articleNormal('''1.1本协议由您和“黑天鹅工作室以及中国矿业大学学工处”(以下简称“我们”)签署，自您确认接受之时起或自您使用校园通的行为发生之时起（以时间在先者为准）生效。
              \n1.2校园通《隐私政策》是本协议不可分割的组成部分，如您使用校园通，视为您同意上述协议及规则。'''),
              _articleBold('二、校园通服务'),
              _articleNormal('''2.1校园通向您提供办公、管理、校园资讯、信息查询等服务。
              \n2.2为更好的为您提供服务，校园通可能不定期对应用进行更新（更新可能采取软件替换、修改、功能强化、版本升级等形式），或者对软件的部分功能效果进行改变或限制。
              \n2.3为正常使用校园通的各项功能，需要设备连接互联网，您需要自行承担相应的网络流量费。
              '''),
              _articleBold('三、账号'),
              _articleNormal('''3.1为体验校园通的服务效果，您可以通过您的学号/工号登陆校园通。 
              \n3.2请妥善保管您的账号及密码，并对您账号下发生的行为承担法律责任。'''),
              _articleBold('四、用户个人信息保护'),
              _articleNormal('我们将会采取合理的措施保护您的个人隐私信息，具体您可以查看《隐私政策》。'),
              _articleBold('五、用户规范'),
              _articleNormal('''【用户内容规范】
              \n您不得利用校园通发布、传播或从事（包括但不限于）如下行为：
              \n5.1.1反对宪法所确定的基本原则的。
              \n5.1.2危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的。
              \n5.1.3损害国家荣誉和利益的。
              \n5.1.4煽动民族仇恨、民族歧视，破坏民族团结的。
              \n5.1.5破坏国家宗教政策，宣扬邪教和封建迷信的。
              \n5.1.6散布谣言，扰乱社会秩序，破坏社会稳定的。
              \n5.1.7散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的。
              \n5.1.8侮辱或者诽谤他人，侵害他人合法权益的.
              \n5.1.9含其含有法律、行政法规禁止的内容信息等。
              \n【用户行为规范】
              \n您在使用校园通时不得存在以下行为：
              \n5.2.1对校园通进行反向工程、反向汇编、反向编译，或者以其他方式尝试获取我们的源代码。
              \n5.2.2对我们拥有知识产权的内容进行使用、出租、出借、复制、修改、链接、转载、汇编、发表、出版、建立镜像站点等。
              \n5.2.3通过非由我们开发/授权的第三方软件、插件、外挂、系统，登录或使用校园通，或制作、发布、传播上述工具。
              \n5.2.4企图干涉、破坏软件系统的正常运行，故意传播恶意程序或病毒以及其他破坏干扰正常网络服务/破坏网络安全的行为。
              \n5.2.5删除校园通上一切关于版权的信息。
              \n5.2.6其他违反法律法规、政策或影响校园通软件正常运行的行为。'''),
              _articleBold('六、第三方产品和服务'),
              _articleNormal('''6.1为更好地提供服务，我们可能会嵌入第三方产品或服务的入口。您在使用第三方提供的产品或服务时，还应遵守第三方的服务规则。
              \n6.2我们无法保证第三方产品及服务的安全性、准确性、有效性或及时性，也无法对第三方提供的服务及产品提供任何担保。您使用第三方软件或服务引发的任何争议或损害，我们不承担任何责任。'''),
              _articleBold('七、知识产权 '),
              _articleNormal('''7.1我们合法持有或基于许可拥有校园通的著作权等知识产权，并受法律法规的保护，但相关权利人依照法律规定应享有的权利除外。
              \n7.2未经我们或相关权利人书面许可，您不得自行或许可任何第三方实施侵犯上述知识产权的行为。
              \n7.3您下载和使用校园通的行为，不代表取得校园通的著作权等内容的授权。未经书面许可，不得实施任何侵权行为。'''),
              _articleBold('八、违约责任'),
              _articleNormal('''8.1您理解并同意，我们有权依合理判断对可能违反法律法规或本协议规定的行为予以制止或处罚，并依据法律法规保存违法行为有关信息向有关部门报告。
              \n8.2您理解并同意，如违反本协议或相关服务条款的规定，导致第三方遭受损失或发起投诉、索赔或维权的，您自行承担相应责任。
              \n8.3您理解并同意，如您的不当行为导致我们被投诉、索赔或遭受行政处罚的，您应当赔偿我们遭受的一切损失。'''),
              _articleBold('九、特别约定'),
              _articleNormal('''9.1我们将尽最大努力确保产品和服务的安全、有效、准确、可靠。但可能会受到多种因素的影响或干扰，导致我们所提供的服务出现如下问题(包括但不限于)：
              \n9.1.1提供的服务无法满足您的需求；
              \n9.1.2网络服务受到干扰，无法保证服务的及时性、安全性、可靠性，遭受黑客入侵，网络中断，电信故障或其他不可抗力情况。
              \n9.2不可抗力包括但不限于地震、台风、游行、罢工、及其他我们不能控制的原因造成的网络服务中断情形，我们将尽全力将您遭受的损失降至最低。
              \n9.3如果您停止使用校园通或服务被终止或取消，我们可以从服务器上永久地删除您的数据。且服务停止、终止或取消后，我们无须向您返还任何数据。'''),
              _articleBold('十、其他'),
              _articleNormal('''10.1本协议签订地为中华人民共和国江苏省徐州市大学路1号中国矿业大学。
              \n10.2本协议的订立、执行和解释及争议的解决均应适用中华人民共和国法律。
              \n10.3若您与我们发生任何争议，应友好协商解决；协商不成的，任何一方均可向合同签订地有管辖权的人民法院提起诉讼。
              \n10.4如本协议部分条款无效或不可执行，本协议的其余条款仍有效并且有约束力。'''),

              Container(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
