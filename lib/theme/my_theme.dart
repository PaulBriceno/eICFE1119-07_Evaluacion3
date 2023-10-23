import 'package:flutter/material.dart';

class MyThme{
  static const Color primary = Color.fromARGB(255, 255, 0, 0);

  static final ThemeData myTheme=ThemeData(
    primaryColor: primary,
    brightness: Brightness.light,
    fontFamily: 'releway',
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 10,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary)
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primary) 
    
  );
}