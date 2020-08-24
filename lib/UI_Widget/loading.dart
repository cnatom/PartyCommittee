import 'package:flui/flui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyhub/tool/Util.dart';
import 'package:flutter_easyhub/tool/config.dart';

import 'colors.dart';

Widget loadingAnimationWave=Tool.getIndicatorWidget(
    EasyHubIndicatorType.beatingRects,
    circleValueColor:
    AlwaysStoppedAnimation(mainColor));

Widget loadingAnimationTwoCircles=Tool.getIndicatorWidget(
    EasyHubIndicatorType.rotatingTwoCircles,
    circleValueColor:
    AlwaysStoppedAnimation(mainColor));

Widget loadingAnimationArticle()=>Container(
    padding: EdgeInsets.all(5),
    child: Card(
        elevation: 0,
        child: Stack(
            children: <Widget>[
                FLSkeleton(
                    shape: BoxShape.circle,
                    margin: EdgeInsets.only(top: 10, left: 10),
                    width: 40,
                    height: 40,
                ),
                FLSkeleton(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                    margin: EdgeInsets.only(left: 60, top: 10, right: 10),
                    height: 20,
                ),
                FLSkeleton(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                    margin: EdgeInsets.only(left: 60, top: 40),
                    width: 300,
                    height: 20,
                ),
                FLSkeleton(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                    margin: EdgeInsets.only(left: 60, top: 70, bottom: 10),
                    width: 100,
                    height: 20,
                ),
            ],
        ),
    )
);

Widget loadingPage(BuildContext context){
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: ()=>Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back_ios,color: mainColor,size: 18,),
      ),
    ),
    body: Center(child: loadingAnimationWave,),
  );
}