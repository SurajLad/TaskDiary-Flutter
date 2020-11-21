import 'package:hive/hive.dart';

part 'label.g.dart';

@HiveType(typeId: 3)
class Label extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int color;

  Label({this.name, this.color});
}
