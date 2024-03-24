import 'package:finances/classes/account.class.dart';
import 'package:finances/pages/home.page.dart';
import 'package:finances/widgets/expenseCards.widget.dart';
import 'package:flutter/material.dart';

import '../classes/boxes.class.dart';
import '../classes/category.class.dart';

class ExpenseViewPage extends StatefulWidget {
  const ExpenseViewPage({super.key});

  @override
  State<ExpenseViewPage> createState() => _ExpenseViewPageState();
}

class _ExpenseViewPageState extends State<ExpenseViewPage> {
  CategoryList categoryList = CategoryList();
  late Category first;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    first = categoryList.categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Expanded(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButton(
                  value: first,
                  isExpanded: true,
                  items: categoryList.categories
                      .map<DropdownMenuItem<Category>>((Category value) {
                    return DropdownMenuItem<Category>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (Category? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      first = value!;
                    });
                  }),
            ),
            Text(first.expenseSum.toStringAsFixed(2) +
                Boxes().boxes[0].get("icon")),
            Text(
                '${(first.expenseSum / (Account().income * (first.percentage / 100)) * 100).round().toStringAsFixed(2)} %'),
            Expanded(
              child: ListView.builder(
                  itemCount: first.expenses.length,
                  itemBuilder: (context, index) {
                    return ExpenseCard(
                        expense: first.expenses[index],
                        delete: ((() {
                          setState(() {
                            // print("removed Expense");
                            first.removeExpense(first.expenses[index]);
                          });
                        })));
                  }),
            ),
          ]),
        );
      },
    );
  }
}
