import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/view/introduction.dart';
import 'const/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void set_locale(BuildContext context , Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.set_locale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;
  void set_locale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  @override
  void initState() {
    super.initState();
    Global.load_language().then((language) {
      setState(() {
        _locale= Locale(language);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Car-Rental-Delivery-App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.main,
          fontFamily: 'Roboto',
        ),
        locale: _locale,
        supportedLocales: [
          Locale('en', ''),
          Locale('ar', '')
        ],
        localizationsDelegates: [
          App_Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (local, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == local!.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: Introduction()
    );
  }
}

