import 'package:finances/pages/home.page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes.class.dart';
import 'expenses.class.dart';

part 'category.class.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  String name = "";
  @HiveField(1)
  double percentage = 0;
  @HiveField(2)
  double expenseSum = 0;
  @HiveField(3)
  List<Expense> expenses = [];

  Category(this.name);

  void expense(String detail, double value)
  {
    expenseSum += value;
    addExpense(detail, value);
    updateBox();
  }

  void removeExpense(Expense expense)
  {
    expenseSum -= expense.expense;
    expenses.remove(expense);
    updateBox();
    notifier.dataChanged();
  }

  void changePercentage(double value)
  {
    percentage = value;
    updateBox();
  }

  void addExpense(String detail, double value)
  {
    Expense expense = Expense(detail, value);
    expenses.add(expense);
    notifier.dataChanged();
  }

  void sumExpenses()
  {
    for (var expense in expenses) {
      expenseSum += expense.expense;
    }
  }

  void updateBox()
  {
    for (var i = 0; i < Boxes().boxCategories().length; i++) {
      if (Boxes().boxCategories().getAt(i).name == name) {
        Boxes().boxCategories().putAt(i, Boxes().boxCategories().getAt(i));
      }
    }
  }
}

class CategoryList{
  List<Category> categories = [];

  // Singleton // +
  static final CategoryList _singleton = CategoryList._internal();

  factory CategoryList() {
    return _singleton;
  }

  CategoryList._internal();
  // Singleton // -

  void addToList(String name)
  {
    var category = Category(name);
    categories.add(category);
    Boxes().boxCategories().add(category);
    notifier.dataChanged();
  }

  void removeFromList(int index) async
  {
    Boxes().boxCategories().delete(Boxes().boxCategories().keyAt(index));
    categories.removeAt(index);
    notifier.dataChanged();
  }

  void initList()
  {
    if (Boxes().boxCategories().isNotEmpty) {
      for (var i = 0; i < Boxes().boxCategories().length; i++) {
        categories.add(Boxes().boxCategories().getAt(i) ?? Category("name"));
      }
    }
  }
}