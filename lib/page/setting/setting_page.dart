import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walie_food/generated/l10n.dart';
import 'package:walie_food/page/page_export.dart';
import 'package:walie_food/routers/routers_export.dart';
import 'package:walie_food/utils/provider/login_provider.dart';
import 'package:walie_food/utils/provider/provider_export.dart';
import 'package:walie_food/utils/util_export.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const routeName = '/SettingPage';

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isOnline = false;
  late bool _checkLanguage;
  String name = 'Hau Tran';
  final _user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    String? languageLocal = PrefsUtil.getString(Constants.LANGUAGE_CHANGE);
    _checkLanguage =
        (languageLocal != null && languageLocal == Constants.ENGLISH);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().getAdapterSize(35),
              bottom: ScreenUtil.getInstance().getAdapterSize(20)),
          child: Text(
            S.current.settings,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: ScreenUtil.getInstance().getAdapterSize(35),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: ScreenUtil.getInstance().screenHeight,
              width: ScreenUtil.getInstance().screenWidth,
              padding:
                  EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
              child: _menuWidget(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userWidget(),
        _themeMode(context),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
        Text(
          S.current.information,
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(16),
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
        _cardFunctions(
            title: S.current.settings,
            widget: const Icon(
              Icons.settings,
              color: Colors.pinkAccent,
            ),
            checkTrailing: true),
        _cardFunctions(
            title: S.current.change_password,
            widget: const Icon(
              Icons.vpn_key,
              color: Colors.pinkAccent,
            ),
            checkTrailing: true,
            onTap: () {
              Navigator.pushNamed(context, ChangePasswordPage.routeName);
            }),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
        Text(
          S.current.notification,
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(16),
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
        _cardFunctions(
            title: S.current.news,
            widget: const Icon(
              Icons.notification_important_rounded,
              color: Colors.pinkAccent,
            ),
            checkTrailing: true,
            onTap: () {
              Navigator.pushNamed(context, NewsPage.routeName);
            }),
        _cardFunctions(
            title: S.current.save_item,
            widget: const Icon(
              Icons.save,
              color: Colors.pinkAccent,
            ),
            checkTrailing: true,
            onTap: () {
              Navigator.pushNamed(context, SaveItemPage.routeName);
            }),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
        Text(
          S.current.region,
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(16),
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
        _cardFunctions(
          title: S.current.language,
          widget: const Icon(
            Icons.language,
            color: Colors.pinkAccent,
          ),
          checkTrailing: true,
          onTap: () async {
            await _showLanguageDialog();
          },
        ),
        _cardFunctions(
            title: S.current.logout,
            widget: const Icon(
              Icons.logout,
              color: Colors.pinkAccent,
            ),
            checkTrailing: true,
            onTap: () async {
              await _showDialogLogout();
            }),
      ],
    );
  }

  Widget _userWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1,
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ViewImageWidget.routeName,
                arguments: ScreenArguments(
                    arg1: _user.photoURL ?? 'assets/img/user.jpg'));
          },
          child: Hero(
            tag: 'dash',
            child: ClipOval(
              child: Image.network(
                _user.photoURL ?? 'assets/img/user.jpg',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          ' ${_user.displayName ?? 'User'}',
          style:
              TextStyle(fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
        ),
        trailing: Icon(
          Icons.navigate_next,
          size: ScreenUtil.getInstance().getAdapterSize(26),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            InfoUserPage.routeName,
            arguments: ScreenArguments(
                arg1: _user.displayName ?? name,
                arg2: _user.photoURL ?? 'assets/img/user.jpg'),
          );
        },
      ),
    );
  }

  Widget _cardFunctions(
      {String? title,
      bool checkTrailing = false,
      Widget? widget,
      GestureTapCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1,
      child: ListTile(
        leading: widget,
        title: Text(
          title ?? 'User',
          style:
              TextStyle(fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
        ),
        trailing: checkTrailing
            ? Icon(
                Icons.navigate_next,
                size: ScreenUtil.getInstance().getAdapterSize(26),
              )
            : const SizedBox(),
        onTap: onTap,
      ),
    );
  }

  Widget _themeMode(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SwitchListTile(
        title: const Text('Dark Mode'),
        value: _isOnline,
        secondary: Icon(
          Icons.color_lens,
          size: ScreenUtil.getInstance().getAdapterSize(26),
          color: Colors.pinkAccent,
        ),
        activeColor: Colors.pinkAccent,
        onChanged: (value) {
          setState(() {
            _isOnline = !_isOnline;
            provider.toggleTheme(value);
          });
        },
      ),
    );
  }

  _showDialogLogout() async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text(S.current.logout)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Text(S.current.want_to_logout)),
            SizedBox(
              height: ScreenUtil.getInstance().getAdapterSize(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: ScreenUtil.getInstance().getAdapterSize(100),
                  child: ElevatedButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogout();
                      PrefsUtil.clear();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, SplashScreen.routeName, (route) => false);
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                    child: Text(S.current.logout),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil.getInstance().getAdapterSize(100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                    child: Text(S.current.cancel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showLanguageDialog() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: ScreenUtil.getInstance().getAdapterSize(200),
              padding:
                  EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.current.choose_language,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                        fontWeight: FontWeight.w700,
                        fontFamily: ''),
                  ),
                  SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
                  _radioCheckLanguage(
                      S.current.vietnamese, _checkLanguage, false),
                  _radioCheckLanguage(S.current.english, _checkLanguage, true),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _radioCheckLanguage(String language, bool value, bool groupValue) {
    final provider = Provider.of<LanguageProvider>(context, listen: false);
    return RadioListTile(
      title: Text(language),
      value: value,
      groupValue: groupValue,
      onChanged: (value) {
        _checkLanguage = !_checkLanguage;
        provider.changeLocale(
            _checkLanguage ? Constants.ENGLISH : Constants.VIETNAMESE);
      },
    );
  }
}
