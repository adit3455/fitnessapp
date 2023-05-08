import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppUtils {
  static const Color appbarBackgroundColor = Color.fromARGB(255, 123, 189, 251);
  static const Color customButtomLeftColor = Color.fromARGB(155, 194, 254, 251);
  static const Color customButtomRightColor =
      Color.fromARGB(148, 168, 254, 251);
  static const Color gradientRightBackgroundColor =
      Color.fromARGB(255, 25, 119, 206);
  static const Color scaffoldBackgroundColor = Color.fromARGB(7, 38, 39, 40);

  static ThemeData themeData = ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.robotoCondensed().fontFamily,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              iconColor: const MaterialStatePropertyAll(Colors.white),
              iconSize: MaterialStatePropertyAll(25.h),
              backgroundColor: const MaterialStatePropertyAll(
                  AppUtils.appbarBackgroundColor),
              textStyle: MaterialStatePropertyAll(TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.h,
                  color: Colors.white)),
              padding: MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h)))),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h)))),
      appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme:
              IconThemeData(color: AppUtils.appbarBackgroundColor, size: 25.h),
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: appbarBackgroundColor)));
}
