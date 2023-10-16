import 'package:finances/classes/category.class.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'account.class.g.dart';

@HiveType(typeId: 0)
class Account
{
  @HiveField(0)
  double income = 0;
  var box;
  
  // Singleton // +
  static final Account _singleton = Account._internal();

  factory Account() {
    return _singleton;
  }

  Account._internal();
  // Singleton // -

  void setIncome(double income)
  {
    this.income = income;
    box.put("income", income);
    // print(box.get("income"));
  }

  double getIncome()
  {
    return income;
  }

  double savedUp()
  {
    double saved = 0;
    double sum = 0;

    for (var category in CategoryList().categories) {
      sum += category.expenseSum;
    }

    saved = income - sum;
    return saved;
  }

  void initAccount()
  {
    box = Hive.box("account");
    if (box.isNotEmpty){
      income = box.get("income");
      // print(income);
    }
    box.put("income", income);
  }

}