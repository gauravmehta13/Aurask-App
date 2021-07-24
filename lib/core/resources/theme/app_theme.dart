import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../meta/Utility/Constants.dart';
import 'app_color.dart';

//?https://medium.com/globant/flutter-dynamic-theme-dark-mode-custom-themes-bded572c8cdf

class AppTheme {
  get darkTheme => ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        selectedRowColor: primaryColor,
        primaryColor: primaryColor,
        accentColor: primaryColor,
        backgroundColor: primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: primaryColor, // background
            onPrimary: Colors.white, // foreground
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
        ),
        primarySwatch: Colors.grey,
        appBarTheme:
            AppBarTheme(brightness: Brightness.dark, color: primaryColor),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        brightness: Brightness.dark,
        canvasColor: AppColors.lightGreyDarkMode,
        accentIconTheme: IconThemeData(color: Colors.white),
      );

  get lightTheme => ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        selectedRowColor: primaryColor,
        primaryColor: primaryColor,
        accentColor: primaryColor,
        backgroundColor: primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: primaryColor, // background
            onPrimary: Colors.white, // foreground
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
        ),
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: primaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        canvasColor: AppColors.white,
        brightness: Brightness.light,
        accentIconTheme: IconThemeData(color: Colors.black),
      );
}
