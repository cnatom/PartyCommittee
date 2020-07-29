


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:party_committee/NetRequest/swiper_get.dart';

import '../NetClass/global.dart';

Widget swiperWidget(){
  return Swiper(
    itemBuilder: _swiperBuilder,
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
Widget _swiperBuilder(BuildContext context, int index) {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      Positioned.fill(
        child: Image.network(
          Global.swiperInfo.data[index].imgUrl,
        ))
//      ),
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
//          Global.photos[index].content,
//          style: TextStyle(color: Colors.white, fontSize: 17),
//        ),
//      ),
    ],
  );
}