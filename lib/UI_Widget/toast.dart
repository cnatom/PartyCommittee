

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

void showToast(BuildContext context,String text){
  Toast.show(text, context,
      backgroundRadius: 20, gravity: Toast.CENTER, duration: 2);
}