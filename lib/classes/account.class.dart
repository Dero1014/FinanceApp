import 'package:finances/classes/category.class.dart';

import 'boxes.class.dart';

class Account
{
  double income = 0;
  
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
    Boxes().boxAccount().put("income", income);
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

  double saveExpectency()
  {
    double savings = 0;
    double sum = 0;

    for (var category in CategoryList().categories) {
      sum += (category.percentage/100) * income;
    }

    savings = income-sum;
    return savings;
  }

  void initAccount()
  {
    if (Boxes().boxAccount().isNotEmpty){
      income = Boxes().boxAccount().get("income");
    }
    Boxes().boxAccount().put("income", income);
  }

}