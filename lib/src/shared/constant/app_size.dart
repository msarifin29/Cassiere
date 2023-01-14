//#GROUP_TEMPLATE theme
import 'package:cassiere/core.dart';
export 'package:cassiere/src/shared/theme/theme_editor/themes/size_box.dart';
import 'package:flutter/material.dart';

var bgColor = const Color(0xFF212332);
var defaultPadding = 16.0;

var successColor = Colors.green[300]!;
var infoColor = Colors.blue[300]!;
var warningColor = Colors.orange[300]!;
var disabledColor = Colors.grey[300]!;

var disabledTextColor = Colors.grey[800];

//#_!#$O!_@$
// Color appbarBackgroundColor = Colors.white;
// Color scaffoldBackgroundColor = Colors.grey[300]!;
// MaterialColor primarySwatch = Colors.blueGrey;
// TextStyle googleFont = GoogleFonts.sora();
// Color drawerBackgroundColor = const Color(0xff404E67);
// Color drawerFontColor = Colors.grey[300]!;

// double cardElevation = 0.8;
// double cardBorderRadius = 24.0;
//#!$O!@)$1@#
class AppSize {
  static const double s08 = 0.8;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s30 = 30.0;
  static const double s36 = 36.0;
  static const double s40 = 40.0;
  static const double s50 = 50.0;
  static const double s60 = 60.0;
  static const double s70 = 70.0;
  static const double s100 = 100.0;
  static const double s150 = 150.0;
  static const double s200 = 200.0;
  static const double s250 = 250.0;
}
//---
// const defaultRadius = 20;
//---

//Text

//Icon
// Color iconColor1 = Colors.grey[700]!;
// Color iconColor2 = Colors.grey[600]!;
// Color iconColor3 = Colors.grey[500]!;
// Color iconColor4 = Colors.grey[500]!;
// Color iconColor5 = Colors.grey[300]!;
// Color iconColor6 = Colors.grey[200]!;

double get sizeHeight {
  return MediaQuery.of(globalContext).size.height;
}

//Width
double get sizeWidth {
  return MediaQuery.of(globalContext).size.width;
}
