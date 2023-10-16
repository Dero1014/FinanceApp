import 'package:finances/classes/account.class.dart';
import 'package:finances/classes/category.class.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool visible;
  const HomeBar(this.title, this.visible);

  @override
  State<HomeBar> createState() => _HomeBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _HomeBarState extends State<HomeBar> {
  var box = Hive.box("Conversion");
  bool convertToEuro = false;

  _HomeBarState() {
    if (!box.containsKey("icon")) {
      box.put("icon", "kn");
    }
    if (box.containsKey("conversion")) {
      convertToEuro = box.get("conversion");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.grey,
      centerTitle: true,
      actions: <Widget>[
        Text(
          box.get("icon"),
          style: const TextStyle(fontSize: 40),
        ),
        Visibility(
          visible: widget.visible,
          child: IconButton(
              onPressed: () {
                setState(() {
                  if (!convertToEuro) {
                    toEuro();
                    box.put("icon", "€");
                  } else {
                    toHrk();
                    box.put("icon", "kn");
                  }
                  convertToEuro = !convertToEuro;
                  box.put("conversion", convertToEuro);
                });
              },
              icon: const Icon(Icons.currency_exchange)),
        ),
      ],
    );
  }

  void toEuro() {
    double account = Account().getIncome();
    setState(() {
      Account().setIncome(account / euroConversion);
    });

    //print(Account().income);

    for (var category in CategoryList().categories) {
      for (var expense in category.expenses) {
        expense.expense = expense.expense / euroConversion;
      }
      category.expenseSum = 0;
      category.sumExpenses();
    }
  }

  void toHrk() {
    double account = Account().getIncome();
    Account().setIncome(account * euroConversion);
    for (var category in CategoryList().categories) {
      for (var expense in category.expenses) {
        expense.expense = expense.expense * euroConversion;
      }
      category.expenseSum = 0;
      category.sumExpenses();
    }
  }
}

//Conversion functions

const double euroConversion = 7.53;
