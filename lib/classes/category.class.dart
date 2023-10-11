import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  var box;

  Category(this.name)
  {
    initBox();
  }

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
  }

  void sumExpenses()
  {
    for (var expense in expenses) {
      expenseSum += expense.expense;
    }
  }

  void updateBox()
  {
    for (var i = 0; i < box.length; i++) {
      if (box.getAt(i).name == name) {
        box.putAt(i, box.getAt(i));
        // print(box.getAt(i).expenses);
        // print("Found it");
      }
    }
  }

  void initBox() async
  {
    await Hive.openBox<Category>("catagories");
    box = Hive.box<Category>("catagories");
  }
}

@HiveType(typeId: 2)
class CategoryList{
  @HiveField(0)
  List<Category> categories = [];
  var box;

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
    box.add(category);
  }

  void removeFromList(int index) async
  {
    print(box.deleteAt(index));
    categories.removeAt(index);    
  }

  void initList()
  {
    box = Hive.box<Category>("catagories");

    if (box.isNotEmpty) {
      for (var i = 0; i < box.length; i++) {
        categories.add(box.getAt(i) ?? Category("name"));
      }
    }
  }
}