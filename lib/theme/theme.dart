import 'package:flutter/material.dart';

// light mode
ThemeData lightMode = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.green,
    selectionHandleColor: Colors.green
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade200,
      secondary: Colors.grey.shade400,
      surface: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade800,
  ),
);


// dark mode
ThemeData darkMode = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.green,
      selectionHandleColor: Colors.green
  ),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade800,
    secondary: Colors.black,
    surface: Colors.grey.shade900,
    inversePrimary: Colors.grey.shade300,
  ),
);