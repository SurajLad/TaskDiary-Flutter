import 'package:flutter/material.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  LabelWidget({this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppConstants.fontTitleColor.withOpacity(0.7),
      ),
      child: Text(
        label,
        style: regularTxt.copyWith(color: Colors.white),
      ),
    );
  }
}
