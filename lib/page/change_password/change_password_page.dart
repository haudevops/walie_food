import 'package:flutter/material.dart';
import 'package:walie_food/generated/l10n.dart';
import 'package:walie_food/utils/constants.dart';
import 'package:walie_food/utils/util_export.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  static const routeName = '/ChangePasswordPage';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _currentPassController = TextEditingController();
  TextEditingController _newPassController = TextEditingController();
  TextEditingController _retypePassController = TextEditingController();

  final _currentPassKey = GlobalKey<FormState>();
  final _newPassKey = GlobalKey<FormState>();
  final _retypePassKey = GlobalKey<FormState>();

  FocusNode _currentPassFocus = FocusNode();
  FocusNode _newPassFocus = FocusNode();
  FocusNode _retypePassFocus = FocusNode();

  String? _oldPass = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oldPass = PrefsUtil.getString(Constants.LOGIN_PASSWORD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.pinkAccent),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil.getInstance().getAdapterSize(100),
                  bottom: ScreenUtil.getInstance().getAdapterSize(20)),
              child: Text(
                S.current.change_password,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil.getInstance().getAdapterSize(35),
                ),
              ),
            ),
            _changePassword(),
          ],
        ),
      ),
    );
  }

  Widget _changePassword() {
    return Column(
      children: [
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20)),
        Form(
          key: _currentPassKey,
          child: TextFormField(
            focusNode: _currentPassFocus,
            autofocus: true,
            controller: _currentPassController,
            decoration: InputDecoration(
              labelText: S.current.enter_old_password,
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
              if (_currentPassKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(_newPassFocus);
              } else {
                FocusScope.of(context).requestFocus(_currentPassFocus);
              }
            },
            validator: (value) {
              if (value!.isEmpty ||
                  RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                if (_currentPassController.text != _oldPass) {
                  return S.current.do_not_duplicate_old_password;
                }
                return S.current.wrong_password;
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20)),
        Form(
          key: _newPassKey,
          child: TextFormField(
            focusNode: _newPassFocus,
            autofocus: false,
            controller: _newPassController,
            decoration: InputDecoration(
              labelText: S.current.enter_new_password,
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
              if (_newPassKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(_retypePassFocus);
              } else {
                FocusScope.of(context).requestFocus(_newPassFocus);
              }
            },
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
        Form(
          key: _retypePassKey,
          child: TextFormField(
            focusNode: _retypePassFocus,
            autofocus: false,
            controller: _retypePassController,
            decoration: InputDecoration(
              labelText: S.current.retype_new_password,
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
              if (_retypePassKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).requestFocus(_retypePassFocus);
              }
            },
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
                  if (_currentPassKey.currentState!.validate() &&
                      _newPassKey.currentState!.validate() &&
                      _retypePassKey.currentState!.validate()) {}
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 1,
                ),
                child: Text(
                  S.current.change_password,
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
