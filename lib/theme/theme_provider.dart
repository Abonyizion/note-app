import 'package:data/theme/theme.dart';
import 'package:flutter/material.dart';


class ThemeProvider with ChangeNotifier {

  //initially start as light mode
  ThemeData _themeData = lightMode;

  // getter method to access the theme from other parts of the code
  ThemeData get themeData => _themeData;

  // getter method to see if we are in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  //method to set the theme to the new selected theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  // toggle between light and dark mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

}