import 'package:flutter/material.dart';

class MyColorSchemes {
  static const lightModeScheme = ColorScheme.light(
    primary: Color(0xFF413867),
    secondary: Color(0xFFEAF2FD),
    background: Color(0xFFEAF2FD),
    surface: Colors.white,
    onBackground: Color(0xFFFEFEFE),
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Color(0xFF413867),
    onSecondary: Color(0xFFD9E4F4),
    onSurface: Color(0xFFC7D0DE),
    brightness: Brightness.light,
    outline: Color.fromARGB(255, 88, 88, 89),
  );

  static const darkModeScheme = ColorScheme.dark(
    primary: Color(0xFFEAF2FD),
    secondary: Color(0xFF413867),
    background: Color(0xFF413867),
    surface: Color(0xFF52487A),
    onBackground: Color(0xFF52487A),
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Color(0xFF413867),
    onSecondary: Color(0xFFD9E4F4),
    onSurface: Colors.white,
    brightness: Brightness.dark,
    outline: Color(0xFFB6BECB),
  );
}
