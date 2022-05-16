import 'package:flutter/material.dart';
import 'package:walie_food/generated/l10n.dart';
import 'package:walie_food/page/page_export.dart';
import 'package:walie_food/utils/util_export.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);
  static const routeName = '/NavigationPage';

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigateToScreen(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            label: S.current.home,
            icon: Icon(
              Icons.home,
              size: ScreenUtil.getInstance().getAdapterSize(20),
            ),
          ),
          BottomNavigationBarItem(
            label: S.current.settings,
            icon: Icon(
              Icons.settings,
              size: ScreenUtil.getInstance().getAdapterSize(20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigateToScreen(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return SettingPage();
      default:
        return HomePage();
    }
  }
}
