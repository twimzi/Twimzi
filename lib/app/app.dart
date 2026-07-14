import 'package:flutter/material.dart';

import '../config/routes/app_router.dart';
import '../core/theme/app_theme.dart';

class TwimziApp extends StatelessWidget {
  const TwimziApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Twimzi',
      debugShowCheckedModeBanner: false,

      theme: TwimziTheme.lightTheme,

      themeMode: ThemeMode.system,

      routerConfig: appRouter,
    );
  }
}