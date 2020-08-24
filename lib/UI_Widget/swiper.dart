import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyhub/tool/Util.dart';
import 'package:flutter_easyhub/tool/config.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:party_committee/UI_Widget/loading.dart';
import '../NetClass/global.dart';
import 'colors.dart';

//轮播图组件
Widget swiperWidget() {
  return Swiper(
    indicatorLayout: PageIndicatorLayout.SCALE,
    itemBuilder: (BuildContext context, int index) {
      return Global.swiperInfo.data != null
          ? (Image.network(
              Global.swiperInfo.data[index].imgCompressedUrl,
              fit: BoxFit.fill,
            ))
          : loadingAnimationWave;
    },
    itemCount: 6,
    pagination: new SwiperPagination(
        builder: DotSwiperPaginationBuilder(
      color: Colors.black54,
      activeColor: Colors.white,
    )),
    scrollDirection: Axis.horizontal,
    autoplay: true,
  );
}

//轮播图Builder
//Widget _swiperBuilder(BuildContext context, int index) {
//  return Container(
//    child: Stack(
//      children: <Widget>[
//        Positioned(
//            child: Image.network(
//              Global.swiperInfo.data[index].imgCompressedUrl,
//            )),
//        Positioned(
//            bottom: 0,
//            child: Opacity(
//              opacity: 0.3,
//              child: Container(
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.width * 0.15,
//                color: Colors.black87,
//              ),
//            )),
//        Positioned(
//          bottom: MediaQuery.of(context).size.width * 0.08,
//          left: 5,
//          child: Text(
//            Global.swiperInfo.data[index].title,
//            style: TextStyle(color: Colors.white, fontSize: 17),
//          ),
//        ),
//      ],
//    ),
//  );
//
//}

//Widget _swiperBuilder(BuildContext context, int index) {
//  return Stack(
////    fit: StackFit.expand,
//    children: <Widget>[
//      Positioned(
////        height: 200,
//        child: Image.network(
//          Global.swiperInfo.data[index].imgCompressedUrl,
//        )),
//      Positioned(
//          bottom: 0,
//          child: Opacity(
//            opacity: 0.3,
//            child: Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.width * 0.15,
//              color: Colors.black87,
//            ),
//          )),
//      Positioned(
//        bottom: MediaQuery.of(context).size.width * 0.08,
//        left: 5,
//        child: Text(
//          Global.swiperInfo.data[index].title,
//          style: TextStyle(color: Colors.white, fontSize: 17),
//        ),
//      ),
//    ],
//  );
//}
