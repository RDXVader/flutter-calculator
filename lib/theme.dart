import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  accentColor: Colors.pink,
  scaffoldBackgroundColor: Color(0xFFFEFDF9),
  fontFamily: AppFonts.primaryFont,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  accentColor: Colors.pink,
  scaffoldBackgroundColor: Color(0xFF100f0e),
  fontFamily: AppFonts.primaryFont,
  iconTheme: IconThemeData(
    color: CustomColors.primaryColor
  )
);


class ThemeChanger with ChangeNotifier {
  final String _key = "theme_preference";
  SharedPreferences _prefs;
  bool _isDarkTheme;
  bool get isDarkTheme => _isDarkTheme;

  ThemeChanger() {
    _isDarkTheme = true;
    _loadTheme();
  }

  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _setTheme();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadTheme() async {
    await _initPrefs();
    _isDarkTheme = _prefs.getBool(_key) ?? true;
    notifyListeners();
  }

  _setTheme() async {
    await _initPrefs();
    _prefs.setBool(_key, _isDarkTheme);
  }
}
