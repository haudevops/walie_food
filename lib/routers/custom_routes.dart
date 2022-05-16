import 'package:flutter/material.dart';
import 'package:walie_food/page/change_password/change_password_page.dart';
import 'package:walie_food/page/news/news_page.dart';
import 'package:walie_food/page/page_export.dart';
import 'package:walie_food/routers/routers_export.dart';
import 'package:walie_food/routers/screen_arguments.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    late ScreenArguments arg;
    final Object? arguments = settings.arguments;
    if (arguments != null) {
      arg = arguments as ScreenArguments;
    }
    switch (settings.name) {
      case SplashScreen.routeName:
        return SlideLeftRoute(SplashScreen());
      case LoginPage.routeName:
        return SlideLeftRoute(LoginPage());
      case HomePage.routeName:
        return SlideLeftRoute(HomePage());
      case SettingPage.routeName:
        return SlideLeftRoute(SettingPage());
      case NavigationPage.routeName:
        return SlideLeftRoute(NavigationPage());
      case ViewImageWidget.routeName:
        return SlideLeftRoute(ViewImageWidget(
          data: arg,
        ));
      case ChangePasswordPage.routeName:
        return SlideLeftRoute(ChangePasswordPage());
      case NewsPage.routeName:
        return SlideLeftRoute(NewsPage());
      case InfoUserPage.routeName:
        return SlideLeftRoute(InfoUserPage(data: arg));
      case SaveItemPage.routeName:
        return SlideLeftRoute(SaveItemPage());
      default:
        throw ('this route name does not exist');
    }
  }
}
