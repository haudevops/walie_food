import 'package:flutter/material.dart';

class AppColor extends ChangeNotifier {
  AppColor();

  static Color colorPrimary = const Color(0xFF101010);
  static Color colorPrimaryDark = const Color(0xFF004B81);
  static Color colorBackground = const Color(0xFF222222);
  static Color colorAppBarDark = const Color(0xFF2a2a2a);
  static Color colorPrimaryButton = Colors.pinkAccent;
  static Color colorBlack = const Color(0xFF000016);
  static Color colorDarkGray = const Color(0xFFEEEEEE);
  static Color colorItemDarkWhite = const Color(0xFF333333);
  static Color colorWhiteDark = Colors.white;
  static Color colorDivider = const Color(0xFF101010);
  static Color colorWhiteGrey = Colors.white;
  static Color colorGray = const Color(0xFF6C7077);
  static Color colorTextLocation = const Color(0xFF131312);
  static Color colorBlue = const Color(0xFF007AFF);
  static Color lineLayout = const Color(0xFFE5E5E5);
  static Color colorTextGray = const Color(0xFF686A71);

  // Color background status
  static Color orderStatusRed = const Color(0xFFF20A39);
  static Color orderStatusGreen = const Color(0xFFE7FFE3);
  static Color orderStatusBlue = const Color(0xFF1791f5);
  static Color orderStatusBluePayment = const Color(0xFF053b64);
  static Color orderStatusGray = const Color(0xFF8B8888);
  static Color orderStatusYellow = const Color(0xFFFFD500);
  static Color orderStatusDarkBlue = const Color(0xFF083358);
  static Color orderStatusSeashell = const Color(0xFFFFF5EC);

  // Color text status
  static Color orderTextGreen = const Color(0xFF207513);
  static Color orderGreenLight = const Color(0xFF008D26);

  void switchMode({bool isDarkTheme = false}) {
    if (isDarkTheme) {
      colorBackground = Colors.white;
      colorDarkGray = const Color(0xFFEEEEEE);
      colorItemDarkWhite = Colors.white;
      colorWhiteDark = const Color(0xFF222222);
      colorDivider = const Color(0xFFF5F5F5);
      colorWhiteGrey = Colors.grey;
      colorTextGray = const Color(0xFF686A71);
      colorAppBarDark = Colors.white;
    } else {
      colorBackground = const Color(0xFF222222);
      colorDarkGray = const Color(0xFF222222);
      colorItemDarkWhite = const Color(0xFF333333);
      colorWhiteDark = Colors.white;
      colorDivider = const Color(0xFF101010);
      colorWhiteGrey = Colors.white;
      colorTextGray = Colors.white;
      colorAppBarDark = const Color(0xFF2a2a2a);
    }
  }
}
