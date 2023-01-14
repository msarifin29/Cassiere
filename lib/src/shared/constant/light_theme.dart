import 'package:cassiere/core.dart';
import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(useMaterial3: true).copyWith(
    // primaryColor: AppColor.greenColor,
    // primarySwatch:  Color(0xffFA533C),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.lightBlueColor,
        // shape: ContinuousRectangleBorder(
        //   borderRadius: BorderRadius.circular(64.0),
        // ),
        shape: const StadiumBorder(),
        foregroundColor: AppColor.whiteColor,
      ),
    ),
    appBarTheme: AppBarTheme(
        surfaceTintColor: AppColor.whiteColor,
        elevation: 0.6,
        titleTextStyle: GoogleFonts.poppins(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 22.0),
        iconTheme: const IconThemeData(
          color: AppColor.whiteColor,
        ),
        actionsIconTheme: const IconThemeData(
          color: AppColor.whiteColor,
        ),
        backgroundColor: AppColor.appBarColor),
    scaffoldBackgroundColor: AppColor.whiteColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // backgroundColor: Color(0xff26354F),
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey[400],
      selectedItemColor: AppColor.greenColor,
    ),
    // drawerTheme: DrawerThemeData(
    //   backgroundColor: drawerBackgroundColor,
    // ),
    // iconTheme: IconThemeData(
    //   color: fontColor,
    // ),
    listTileTheme: const ListTileThemeData(
      selectedColor: Colors.red,
    ),
    // textTheme: TextTheme(
    //   bodyText1: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    //   bodyText2: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    //   headline1: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    //   headline2: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    //   headline3: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    //   headline4: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    //   displaySmall: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    //   displayMedium: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    //   displayLarge: CurrentTheme.fontFamily.copyWith(
    //     color: CurrentTheme.textColor,
    //   ),
    // ),
    cardTheme: CardTheme(
      elevation: AppSize.s08,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
    ),
    // chipTheme: const ChipThemeData(),
    // tabBarTheme: TabBarTheme(
    //   labelColor: fontColor,
    // ),
  );
}
