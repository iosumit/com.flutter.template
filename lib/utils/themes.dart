import 'package:flutter/material.dart';

/*

Toggle Themes
Provider.of<ThemeProvider>(context, listen: false).toggleTheme();

Change Language
Provider.of<ThemeProvider>(context, listen: false)
                  .changeAppLanguage(Locale('hi'));

*/

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = Locale('hi');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void toggleTheme() {
    if (_themeMode == ThemeMode.system) {
      _themeMode = ThemeMode.light;
    } else if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  void changeAppLanguage(Locale locale) {
    _locale = locale;
  }
}

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.orange),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch(
            brightness: Brightness.dark, primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.orange),
  );
}
