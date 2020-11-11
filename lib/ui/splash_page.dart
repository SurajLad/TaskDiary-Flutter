import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';
import 'package:xno_taskapp/ui/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      LayoutHelper.instance.width = Get.width;
      LayoutHelper.instance.height = Get.height;
      LayoutHelper.instance.fontSize = Get.height > 700 ? 16 : 15;

      Get.to(HomePage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appBackgroundColor,
    );
  }
}
