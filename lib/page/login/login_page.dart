import 'package:flutter/material.dart';
import 'package:walie_food/generated/l10n.dart';
import 'package:walie_food/log/logger.dart';
import 'package:walie_food/page/home/home_page.dart';
import 'package:walie_food/utils/constants.dart';
import 'package:walie_food/utils/screen_util.dart';
import 'package:walie_food/utils/util_export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();

  final _userNameKey = GlobalKey<FormState>();
  final _userPasswordKey = GlobalKey<FormState>();

  FocusNode _userNameFocus = FocusNode();
  FocusNode _userPasswordFocus = FocusNode();

  String _token = '';
  String _password = '';

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
          child: Container(
            width: ScreenUtil.getInstance().getAdapterSize(200),
            child: ElevatedButton(
                onPressed: () {
                  if(_userNameKey.currentState!.validate() && _userPasswordKey.currentState!.validate()){
                    _token = _userNameController.text + _userPasswordController.text;
                    _password = _userPasswordController.text;
                    print('Token: $_token');
                    PrefsUtil.putString(Constants.LOGIN_TOKEN, _token);
                    PrefsUtil.putString(Constants.LOGIN_PASSWORD, _password);
                    Navigator.pushNamed(context, HomePage.routeName).then((value) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Bạn chưa có tài khoản? ',style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(16),
              color: Colors.black45,
            ),),
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
