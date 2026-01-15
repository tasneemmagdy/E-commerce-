import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme  = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('1E1E1E'),
    selectedItemColor: Colors.amber,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    type: BottomNavigationBarType.fixed,
  ),
  scaffoldBackgroundColor: HexColor('121212'),
  cardColor: HexColor('1E1E1E'),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor : HexColor('333739'),
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarBrightness: Brightness.light,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  cardColor: Colors.white,

  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor : Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      elevation: 20.0
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black
      ,
    ),
  ),
);