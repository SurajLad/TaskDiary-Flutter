import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';

void showLoading(BuildContext context) {
  Get.dialog(WillPopScope(
    onWillPop: () {
      return;
    },
    child: Center(
      child: SpinKitWanderingCubes(
        color: Colors.white,
        size: 35,
      ),
    ),
  ));
}

void showSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    animationDuration: Duration(seconds: 1),
    backgroundColor: AppConstants.appThemeColor,
    titleText: Text(
      title,
      style: medBoldTxt.copyWith(color: Colors.white),
    ),
    messageText: Text(
      message,
      style: regularTxt.copyWith(color: Colors.white),
    ),
    borderRadius: 16
  );
}
