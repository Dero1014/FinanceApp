import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'account.class.g.dart';

@HiveType(typeId: 0)
class Account
{
  @HiveField(0)
  int income = 0;
  var box;
  
  // Singleton // +
  static final Account _singleton = Account._internal();

  factory Account() {
    return _singleton;
  }

  Account._internal();
  // Singleton // -

  void setIncome(int income)
  {
    this.income = income;
    box.put("income", income);
    // print(box.get("income"));
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