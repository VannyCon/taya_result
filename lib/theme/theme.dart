import 'package:flutter/material.dart';

class MyColorSchemes {
  static const lightModeScheme = ColorScheme.light(
    primary: Color(0xFF383060),
    secondary: Color(0xFFEAF2FD),
    background: Color(0xFFEAF2FD),
    surface: Colors.white,
    onBackground: Color(0xFFFEFEFE),
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Color(0xFF383060),
    onSecondary: Color(0xFFD9E4F4),
    onSurface: Color(0xFFC7D0DE),
    brightness: Brightness.light,
    outline: Color.fromARGB(255, 88, 88, 89),
  );

  static const darkModeScheme = ColorScheme.dark(
    primary: Color(0xFFEAF2FD),
    secondary: Color(0xFF383060),
    background: Color(0xFF282241),
    surface: Color(0xFF383060),
    onBackground: Color(0xFF383060),
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Color(0xFF383060),
    onSecondary: Color(0xFFD9E4F4),
    onSurface: Colors.white,
    brightness: Brightness.dark,
    outline: Color(0xFFB6BECB),
  );
}
