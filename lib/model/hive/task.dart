import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  DateTime startTime;

  @HiveField(3)
  DateTime endTIme;

  @HiveField(4)
  String description;

  @HiveField(5)
  String statusTag;

  Task({this.name,this.date,this.startTime,this.endTime,this.statusTag});
}
