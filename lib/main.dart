import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xno_taskapp/ui/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: SplashPage(),
    );
  }
}
