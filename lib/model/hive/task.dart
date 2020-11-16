import 'package:hive/hive.dart';
import 'package:xno_taskapp/model/hive/user.dart';

part 'task.g.dart';


@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  User user;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  DateTime startTime;

  @HiveField(4)
  DateTime endTime;

  @HiveField(5)
  String description;

  @HiveField(6)
  String statusTag;

  Task(
      {this.name,
      this.user,
      this.date,
      this.startTime,
      this.endTime,
      this.description,
      this.statusTag});
}
