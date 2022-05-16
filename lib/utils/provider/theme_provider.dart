import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:walie_food/utils/util_export.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeProvider() {
    _getThemeLocal();
  }

  _getThemeLocal() async {
    final isDarkMode = PrefsUtil.getBool(Constants.THEME_APP);

    if (isDarkMode != null) {
      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      AppColor().switchMode(isDarkTheme: isDarkMode);
    } else {
      var brightness = SchedulerBinding.instance!.window.platformBrightness;
      PrefsUtil.putBool(Constants.THEME_APP, brightness == Brightness.dark);
      AppColor().switchMode(isDarkTheme: brightness == Brightness.dark);
    }
    notifyListeners();
  }

  void toggleTheme(bool isDarkMode) {
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    PrefsUtil.putBool(Constants.THEME_APP, isDarkMode);
    AppColor().switchMode(isDarkTheme: isDarkMode);
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      backgroundColor: AppColor.colorBackground,
      brightness: Brightness.dark,
      textTheme: TextTheme(),
      appBarTheme: AppBarTheme(
        color: AppColor.colorAppBarDark,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        foregroundColor: AppColor.colorAppBarDark,
        iconTheme: IconThemeData(color: AppColor.colorPrimaryButton),
      ),
      primaryColor: AppColor.colorAppBarDark,
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        background: AppColor.colorAppBarDark,
        primary: Colors.white,
        onPrimary: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.colorPrimaryButton,
      ),
      iconTheme: IconThemeData(color: AppColor.colorPrimaryButton),
      toggleableActiveColor: AppColor.colorPrimaryButton,
      indicatorColor: AppColor.colorPrimaryButton,
      fontFamily: 'Lato');

  static final lightTheme = ThemeData(
      backgroundColor: AppColor.colorBackground,
      brightness: Brightness.light,
      textTheme: TextTheme(),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        foregroundColor: AppColor.colorAppBarDark,
        iconTheme: IconThemeData(color: AppColor.colorPrimaryButton),
      ),
      primaryColor: AppColor.colorAppBarDark,
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        background: AppColor.colorAppBarDark,
        primary: AppColor.colorPrimaryButton,
        onPrimary: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.colorPrimaryButton,
      ),
      iconTheme: IconThemeData(color: AppColor.colorPrimaryButton),
      toggleableActiveColor: AppColor.colorPrimaryButton,
      indicatorColor: AppColor.colorPrimaryButton,
      fontFamily: 'Lato');
}
