
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color:primaryTheame,fontFamily: "Inter",fontWeight: FontWeight.w500,fontSize: 18 ),
      color: primaryTheame,
      iconTheme: IconThemeData(color: primaryTheame),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryTheame,
    ),
    iconTheme: const IconThemeData(
      color: primaryTheame,
    ),
    textTheme:  const TextTheme(
      titleSmall: TextStyle(fontSize: 14.0,fontWeight:FontWeight.w400, color: blackColor,fontFamily: "Inter"),
      titleMedium: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400, color: blackColor,fontFamily: "Inter"),
      bodySmall: TextStyle(fontSize: 13.0,fontWeight:FontWeight.normal, color: blackColor,fontFamily: "Inter"),
      bodyMedium: TextStyle(fontSize: 16.0,fontWeight:FontWeight.normal, color: blackColor,fontFamily: "Inter"),
      labelMedium: TextStyle(fontSize: 16.0,fontWeight:FontWeight.normal, color: blackColor,fontFamily: "Inter"),
      labelSmall: TextStyle(fontSize: 14.0,fontWeight:FontWeight.normal, color: darkGrey,fontFamily: "Inter"),
    ),
    dividerTheme: const DividerThemeData(
        color: darkGrey
    ),
  );
}

TextStyle fontStyleMedium({
  Color color = blackColor,
  double fontSize = 14,
}) {
  return GoogleFonts.poppins(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
  );
}