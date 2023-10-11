import 'package:flutter/material.dart';
import '../classes/boxes.class.dart';
import '../classes/expenses.class.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              expense.expenseDetails,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '${expense.expense.toStringAsFixed(2)} ${Boxes().boxes[0].get("icon")}',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
              ),
            ),
            IconButton(
              onPressed: () {
                delete();
              },
              icon: Icon(Icons.delete, color: Colors.red[300]),
            )
          ],
        ),
      ),
    );
  }
}
