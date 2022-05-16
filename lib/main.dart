import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:walie_food/generated/l10n.dart';
import 'package:walie_food/page/page_export.dart';
import 'package:walie_food/routers/routers_export.dart';
import 'package:walie_food/utils/provider/provider_export.dart';
import 'package:walie_food/utils/util_export.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Widget app = await initializeApp();
  runApp(app);
}

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsUtil.getInstance();
  return MyApp();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider()),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        )
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Walie App',
          locale: Provider.of<LanguageProvider>(context, listen: true)
              .currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.allRoutes,
          themeMode: Provider.of<ThemeProvider>(context).themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
