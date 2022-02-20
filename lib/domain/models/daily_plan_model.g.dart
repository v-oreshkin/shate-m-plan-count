// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_plan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyPlanAdapter extends TypeAdapter<DailyPlan> {
  @override
  final int typeId = 0;

  @override
  DailyPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyPlan(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyPlan obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.plan)
      ..writeByte(1)
      ..write(obj.floor)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
