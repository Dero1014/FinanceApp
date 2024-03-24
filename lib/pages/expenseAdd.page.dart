import 'package:finances/classes/account.class.dart';
import 'package:finances/classes/category.class.dart';
import 'package:finances/pages/home.page.dart';
import 'package:flutter/material.dart';

import '../classes/boxes.class.dart';

class ExpenseAddPage extends StatefulWidget {
  const ExpenseAddPage({super.key});

  @override
  State<ExpenseAddPage> createState() => _ExpenseAddPageState();
}

class _ExpenseAddPageState extends State<ExpenseAddPage> {
  final numberControler = TextEditingController();
  final detailsControler = TextEditingController();
  CategoryList categoryList = CategoryList();
  Category first = Category("das");

  @override
  void initState()
  {
    super.initState();
    first = categoryList.categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, child) => Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: numberControler,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Expense in ${Boxes().boxes[0].get("icon")}',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        //Clear text from input
                        numberControler.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ))
                ),
                TextField(
                  controller: detailsControler,
                  decoration: InputDecoration(
                    hintText: "Expense details..",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        //Clear text from input
                        detailsControler.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ))
                ),
                TextButton(
                  onPressed: () {
                    for (var category in categoryList.categories) {
                      if (category == first) {
                        setState(() {
                          if (detailsControler.text == "" || numberControler.text == "") {
                            //print("No expense has been added");
                            return;
                          }
                          category.expense(detailsControler.text, double.parse(numberControler.text));
                          detailsControler.clear();
                          numberControler.clear();
                        });
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey[600],
                  ),
                  child: const Text("Add"),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButton(
                    value: first,
                    isExpanded: true,
                    items: categoryList.categories.map<DropdownMenuItem<Category>>((Category value)
                    {
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
                    }
                    ),
                ),
                Text(first.expenseSum.toStringAsFixed(2) + Boxes().boxes[0].get("icon")),
                Text("${(first.expenseSum/(Account().income*(first.percentage/100))*100).round().toStringAsFixed(2)}%")
              ],
              )
            ),
      ),
    );
  }
}