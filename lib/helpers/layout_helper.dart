import 'package:hive/hive.dart';

class LayoutHelper {
  double width;
  double height;
  double fontSize;
  Box taskList;
  Box userList;
  Box labelList;

  LayoutHelper._internal();

  static final LayoutHelper instance = LayoutHelper._internal();
}
