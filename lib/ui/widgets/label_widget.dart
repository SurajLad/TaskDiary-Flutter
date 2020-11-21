import 'package:flutter/material.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final int color;
  LabelWidget({this.label,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(color),
      ),
      child: Text(
        label,
        style: regularTxt.copyWith(color: Colors.white),
      ),
    );
  }
}
