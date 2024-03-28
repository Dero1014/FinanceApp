// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      fields[0] as String,
    )
      ..percentageBudget = fields[1] as double
      ..budget = fields[2] as double
      ..usedPercentage = fields[3] as double
      ..expenseSum = fields[4] as double
      ..expenses = (fields[5] as List).cast<Expense>();
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.percentageBudget)
      ..writeByte(2)
      ..write(obj.budget)
      ..writeByte(3)
      ..write(obj.usedPercentage)
      ..writeByte(4)
      ..write(obj.expenseSum)
      ..writeByte(5)
      ..write(obj.expenses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
