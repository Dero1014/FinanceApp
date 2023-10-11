import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'expenses.class.g.dart';

@HiveType(typeId: 3)
class Expense
{
  @HiveField(0)
  String expenseDetails = "";
  @HiveField(1)
  int expense = 0;

  Expense(this.expenseDetails, this.expense);
}