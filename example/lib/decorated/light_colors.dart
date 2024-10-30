import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 0),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: Color(0xffCEFE38)),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.white),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.white, fontSize: 42, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
    displaySmall: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
  ),
);
