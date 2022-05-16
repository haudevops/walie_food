import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:walie_food/page/page_export.dart';
import 'package:walie_food/utils/constants.dart';
import 'package:walie_food/utils/screen_util.dart';
import 'package:walie_food/utils/util_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkToken();
  }

  void _checkToken() async{
    await Future.delayed(Duration(seconds: 3), (){
      _token = PrefsUtil.getString(Constants.LOGIN_TOKEN);
      if(_token!.isNotEmpty && _token != null){
        print('Token: $_token');
        Navigator.pushNamedAndRemoveUntil(context, NavigationPage.routeName, (Route<dynamic> route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: ScreenUtil.getInstance().screenHeight,
            width: ScreenUtil.getInstance().screenWidth,
            child: Image.asset(
              'assets/img/img_splash_screen.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(40),
                    fontFamily: 'Horizon',
                  fontWeight: FontWeight.w700
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Walie'),
                    WavyAnimatedText('Look at Future'),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
