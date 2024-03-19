import 'package:flutter/material.dart';
import 'expenseAdd.page.dart';
import 'expenseView.page.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          ExpenseAddPage(),
          VerticalDivider(),
          ExpenseViewPage()
        ],
      ),
    );
  }
}
