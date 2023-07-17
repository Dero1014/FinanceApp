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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Expenses"),
          centerTitle: true,
          backgroundColor: Colors.grey,
          bottom: const TabBar(
            tabs:  <Widget>[
              Tab(icon: Icon(Icons.add)),
              Tab(icon: Icon(Icons.align_horizontal_left))
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ExpenseAddPage(),
            ExpenseViewPage()
          ],
        ),
      ),
    );
  }
}
