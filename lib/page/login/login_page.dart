import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:walie_food/generated/l10n.dart';
import 'package:walie_food/log/logger.dart';
import 'package:walie_food/page/page_export.dart';
import 'package:walie_food/utils/util_export.dart';

import '../../utils/provider/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final _userNameKey = GlobalKey<FormState>();
  final _userPasswordKey = GlobalKey<FormState>();

  final _userNameFocus = FocusNode();
  final _userPasswordFocus = FocusNode();

  String _token = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    hiddenKeyBoard();
  }

  void hiddenKeyBoard() {
    Future.delayed(const Duration(),
        () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().getAdapterSize(200)),
          padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
          child: _bodyWidget(),
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.welcome_to_walie,
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(20),
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20)),
        Form(
          key: _userNameKey,
          child: TextFormField(
            focusNode: _userNameFocus,
            autofocus: true,
            controller: _userNameController,
            decoration: InputDecoration(
              labelText: S.current.enter_username,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: Colors.pinkAccent),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onFieldSubmitted: (value) {
              if (_userNameKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(_userPasswordFocus);
              } else {
                FocusScope.of(context).requestFocus(_userNameFocus);
              }
            },
            validator: (value) {
              if (value!.isEmpty ||
                  RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return S.current.enter_username;
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20)),
        Form(
          key: _userPasswordKey,
          child: TextFormField(
            focusNode: _userPasswordFocus,
            autofocus: false,
            controller: _userPasswordController,
            decoration: InputDecoration(
              labelText: S.current.enter_password,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: Colors.pinkAccent),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty ||
                  RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return S.current.wrong_password;
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20)),
        Center(
          child: SizedBox(
            width: ScreenUtil.getInstance().getAdapterSize(250),
            child: ElevatedButton(
                onPressed: () {
                  if (_userNameKey.currentState!.validate() &&
                      _userPasswordKey.currentState!.validate()) {
                    _token =
                        _userNameController.text + _userPasswordController.text;
                    _password = _userPasswordController.text;
                    if (kDebugMode) {
                      print('Token: $_token');
                    }
                    PrefsUtil.putString(Constants.LOGIN_TOKEN, _token);
                    PrefsUtil.putString(Constants.LOGIN_PASSWORD, _password);
                    Navigator.pushNamed(context, NavigationPage.routeName)
                        .then((value) {
                      _userPasswordController.clear();
                      FocusScope.of(context).requestFocus(_userPasswordFocus);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 1,
                ),
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                  ),
                )),
          ),
        ),
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something Went Wrong!'),
              );
            }
            if (snapshot.hasData) {
              if (kDebugMode) {
                print('Data: ${snapshot.data}');
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                    context, NavigationPage.routeName, (route) => false);
              });
            }
            return Center(
              child: SizedBox(
                width: ScreenUtil.getInstance().getAdapterSize(250),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 1,
                  ),
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    size: ScreenUtil.getInstance().getAdapterSize(16),
                  ),
                  label: Text(
                    'Đăng nhập bằng Google',
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Bạn chưa có tài khoản? ',
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                color: Colors.black45,
              ),
            ),
            TextButton(
              onPressed: () {
                DebugLog.show('Ok');
              },
              child: Text(
                'Đăng ký',
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
