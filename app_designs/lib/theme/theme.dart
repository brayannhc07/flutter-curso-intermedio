import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;

  late ThemeData _currentTheme;

  bool get darkTheme => _darkTheme;
  bool get customTheme => _customTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeChanger(int theme) {
    // _currentTheme = ThemeData.light();
    switch (theme) {
      case 1:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light(useMaterial3: true).copyWith(
            colorScheme:
                const ColorScheme.light().copyWith(secondary: Colors.pink));
        break;
      case 2:
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme:
                const ColorScheme.light().copyWith(secondary: Colors.pink));
        break;
      case 3:
        _darkTheme = false;
        _customTheme = true;
        _currentTheme = ThemeData.dark(useMaterial3: true);
        break;
    }
  }

  set darkTheme(bool value) {
    _customTheme = false;
    _darkTheme = value;

    _currentTheme = value
        ? ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme:
                const ColorScheme.light().copyWith(secondary: Colors.pink))
        : ThemeData.light(useMaterial3: true).copyWith(
            colorScheme:
                const ColorScheme.light().copyWith(secondary: Colors.pink));

    notifyListeners();
  }

  set customTheme(bool value) {
    _customTheme = value;
    _darkTheme = false;

    _currentTheme = value
        ? ThemeData.dark(useMaterial3: true).copyWith(
            textTheme:
                const TextTheme(bodyText1: TextStyle(color: Colors.white)),
            primaryColorLight: Colors.white,
            scaffoldBackgroundColor: const Color(0xff16202B),
            colorScheme: const ColorScheme.dark(secondary: Color(0xff48A0EB)))
        : ThemeData.light(useMaterial3: true).copyWith(
            colorScheme:
                const ColorScheme.light().copyWith(secondary: Colors.pink));

    notifyListeners();
  }
}
