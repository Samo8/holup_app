import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() => runApp(HolupApp());

class HolupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Holup application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
