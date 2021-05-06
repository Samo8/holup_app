import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:get/get.dart';
import 'package:holup/app/constants/theme_constants.dart';

import 'app/routes/app_pages.dart';

Future main() async {
  await dot_env.load();
  runApp(HolupApp());
}

class HolupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Holup application',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeConstants.lightTheme,
      darkTheme: ThemeConstants.darkTheme,
    );
  }
}
