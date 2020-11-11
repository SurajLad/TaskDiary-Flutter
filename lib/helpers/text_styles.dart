import 'package:flutter/material.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';

TextStyle regularTxt = TextStyle(
  fontFamily: 'Poppins',
  fontSize: LayoutHelper.instance.fontSize-2,
  color: Colors.black,
);

TextStyle medTxt = TextStyle(
  fontFamily: 'Poppins',
  fontSize: LayoutHelper.instance.fontSize + 2,
  color: Colors.black,
);

TextStyle medBoldTxt = TextStyle(
  fontFamily: 'Poppins',
  fontSize: LayoutHelper.instance.fontSize + 2,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);
