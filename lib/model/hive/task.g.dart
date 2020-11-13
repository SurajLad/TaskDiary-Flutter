// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {

  @override
  final typeId = 1;
  
  @override
  Task read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      name: fields[0] as String,
      user: fields[1] as User,
      date: fields[2] as DateTime,
      startTime: fields[3] as DateTime,
      endTime: fields[4] as DateTime,
      statusTag: fields[6] as String,
    )..description = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.statusTag);
  }
}
