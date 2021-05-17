import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app/constants/theme_constants.dart';
import 'app/routes/app_pages.dart';

Future main() async {
  await dot_env.load();
  runApp(HolupApp());
}

class HolupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Holup',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeConstants.lightTheme,
      darkTheme: ThemeConstants.darkTheme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('sk'),
      ],
      locale: const Locale('sk'),
    );
  }
}
