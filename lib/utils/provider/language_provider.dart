import 'package:flutter/material.dart';
import 'package:walie_food/utils/util_export.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _currentLocale;

  Locale get currentLocale => _currentLocale;

  LanguageProvider() {
    _getLanguageLocal();
  }

  void _getLanguageLocal() async {
    String? languageLocal = PrefsUtil.getString(Constants.LANGUAGE_CHANGE);
    if (languageLocal != null && languageLocal.isNotEmpty) {
      _currentLocale = Locale(languageLocal);
    } else {
      _currentLocale = const Locale(Constants.VIETNAMESE);
    }
  }

  void changeLocale(String locale) {
    _currentLocale = Locale(locale);
    PrefsUtil.putString(Constants.LANGUAGE_CHANGE, locale);
    notifyListeners();
  }
}
