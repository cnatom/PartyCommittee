import 'package:flutter/cupertino.dart';
import 'package:flutter_easyhub/tool/Util.dart';
import 'package:flutter_easyhub/tool/config.dart';

import 'colors.dart';

Widget loadingAnimation = Tool.getIndicatorWidget(
    EasyHubIndicatorType.beatingRects,
    circleValueColor:
    AlwaysStoppedAnimation(mainColor));