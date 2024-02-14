import 'package:flutter/material.dart';
import '../classes/boxes.class.dart';
import '../classes/expenses.class.dart';
import '../classes/widgethelper.class.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final Function() delete;

  const ExpenseCard({super.key, required this.expense, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              WidgetHelper().maxStringAllowed(expense.expenseDetails),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(),
            Text(
              '${expense.expense.toStringAsFixed(2)} ${Boxes().boxes[0].get("icon")}',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
              ),
            ),
            IconButton(
              onPressed: () {
                WidgetHelper().areYouSure(context, "You are about to delete an expense, are you sure?", delete);
              },
              icon: Icon(Icons.delete, color: Colors.red[300]),
            )
          ],
        ),
      ),
    );
  }
}
