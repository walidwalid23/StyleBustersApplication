import 'package:flutter/material.dart';
import 'colors_manager.dart';

class AppThemeManager {
  static final ThemeData darkMode = ThemeData(
    splashColor: ColorsManager.themeColor1,
    secondaryHeaderColor: Color.fromARGB(255, 94, 94, 94),
    primaryColor: Colors.grey[700],
    scaffoldBackgroundColor: Color.fromARGB(255, 85, 84, 84),
    colorScheme: ColorScheme.dark(
        primary: Colors.white, secondary: Color.fromARGB(255, 255, 255, 255)),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 85, 84, 84)),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.deepOrange),
      bodyText2: TextStyle(color: Colors.deepOrange),
    ).apply(
      bodyColor: Colors.deepOrange,
      displayColor: Colors.deepOrange,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 85, 84, 84),
    ),
  );

  static final ThemeData lightMode = ThemeData(
    splashColor: Color.fromARGB(255, 255, 0, 0),
    secondaryHeaderColor: Color.fromARGB(255, 94, 94, 94),
    primaryColor: Color.fromARGB(255, 231, 0, 0),
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 254, 254),
    colorScheme:
        ColorScheme.light(primary: Colors.white, secondary: Color(0xFFF3A953)),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(backgroundColor: ColorsManager.themeColor1),
  );
}
