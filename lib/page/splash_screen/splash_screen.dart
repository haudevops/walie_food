import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  String? token = '';

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void _loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void _listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      if (kDebugMode) print('User granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      if (kDebugMode) print('User granted provisional permission');
    }else{
      if (kDebugMode) print('User declined or has not accepted permission');
    }
  }

  void _getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            token = token;
            if (kDebugMode) {
              print('Token: $token');
            }
          });
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkToken();
    _loadFCM();
    _listenFCM();
    _requestPermission();
    _getToken();
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
