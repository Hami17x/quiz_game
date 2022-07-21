import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/view_model/question_provider.dart';

import 'package:quiz_game/onboard_provider.dart';
import 'package:quiz_game/pages/onboarding_page.dart';
import 'package:quiz_game/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game/view/home.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("showHome") ?? false;
  //final showHome = false;

  FlutterNativeSplash.remove();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('tr')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => OnBoardProvider()),
              ChangeNotifierProvider(
                  create: (context) => QuestionProvider(context)),
              ChangeNotifierProvider(
                  create: (context) => ThemeProvider(
                      isLightTheme: prefs.getBool("isLightTheme") ?? true))
            ],
            builder: (context, child) {
              return MyApp(showHome: showHome);
            })),
  );
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // DenemeUtils.getQues(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: context.watch<ThemeProvider>().currentTheme,
      home: showHome ? Home() : OnboardingPage(),
    );
  }
}
