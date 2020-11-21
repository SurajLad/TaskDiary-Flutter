import 'package:flutter/material.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  CustomTextField({this.controller, this.hintText, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[950],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: AppConstants.appThemeColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: medTxt.copyWith(color: Colors.black54),
          border: InputBorder.none,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppConstants.fontTitleColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppConstants.fontTitleColor),
          ),
        ),
      ),
    );
  }
}
