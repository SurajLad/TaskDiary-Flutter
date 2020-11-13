import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'label.g.dart';

@HiveType(typeId: 3)
class Label extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  Color color;

  Label({this.name, this.color});
}
