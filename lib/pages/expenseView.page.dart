import 'package:finances/classes/account.class.dart';
import 'package:finances/widgets/expenseCards.widget.dart';
import 'package:flutter/material.dart';

import '../classes/category.class.dart';

class ExpenseViewPage extends StatefulWidget {
  const ExpenseViewPage({super.key});

  @override
  State<ExpenseViewPage> createState() => _ExpenseViewPageState();
}

class _ExpenseViewPageState extends State<ExpenseViewPage> {
  CategoryList categoryList = CategoryList();
  Account account = Account();
  late Category first;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    first = categoryList.categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
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
        Text(first.expenseSum.toString()),
        Text('${(first.expenseSum / (account.income * (first.percentage / 100)) *100).round().toString()} %'),
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
  }
}
