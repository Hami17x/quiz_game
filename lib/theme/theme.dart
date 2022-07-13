import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({required this.isLightTheme});

  Future<void> changeTheme() async {
    isLightTheme = !isLightTheme;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLightTheme", isLightTheme);
    notifyListeners();
  }

  ThemeData get currentTheme =>
      isLightTheme ? ThemeData.light() : ThemeData.dark();
}
