import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String category;

  User({this.name, this.category});
}
