
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taba3ni/config/routes/app_router.dart';
import 'package:taba3ni/core/theme/app_theme.dart';

class Taba3ni extends StatelessWidget {
  const Taba3ni({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      useInheritedMediaQuery : true,
    //   locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Taba3ni',
      debugShowCheckedModeBanner: false,
   locale: const Locale('ar', 'EG'), // Set Arabic locale
        supportedLocales: const [
    Locale('en', 'US'),
    Locale('ar', 'EG'),
  ],
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
      theme: AppTheme.darkTheme, // Use dark theme for the app
         //    theme: AppTheme.lightTheme, // Use dark theme for the app

    routerConfig: appRouter,
    );
  }
}