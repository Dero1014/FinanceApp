import 'package:finances/classes/widgethelper.class.dart';
import 'package:finances/pages/account.page.dart';
import 'package:finances/pages/category.page.dart';
import 'package:finances/pages/expenses.page.dart';
import 'package:finances/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../classes/boxes.class.dart';
import '../classes/category.class.dart';
import 'dart:io';

class MyNotifier extends ValueNotifier {
  MyNotifier(value) : super(value);

  void dataChanged() {
    notifyListeners();
  }
}

final MyNotifier notifier = MyNotifier(int);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Options regarding n
  int navigationRailIndex = 0;
  NavigationRailLabelType navigationLabelType =
      NavigationRailLabelType.selected;
  double navigationAlignment = -1;

  void nothin() {}

  void deleteBoxes() {
    Boxes().boxAccount().clear();
    Boxes().boxCategories().clear();
    Boxes().boxConversion().clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeBar("Home", true),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: navigationRailIndex,
            groupAlignment: navigationAlignment,
            labelType: navigationLabelType,
            useIndicator: true,
            indicatorColor: Colors.amber,
            onDestinationSelected: (int index) {
              setState(() {
                navigationRailIndex = index;
              });
            },
            trailing: Column(children: <Widget>[
              TextButton(
                onPressed: () async {
                  DateTime now = DateTime.now();
                  DateTime date = DateTime(now.year, now.month, now.day);
                  DateTime monthAgo = date.subtract(const Duration(days: 30));

                  var catList = CategoryList();
                  String data =
                      'Bills dating from ${DateFormat('dd-MM-yyyy').format(monthAgo)} to ${DateFormat('dd-MM-yyyy').format(date)}\n';

                  for (var category in catList.categories) {
                    String catSave =
                        '\n${category!.name} [${category!.getBudget().toStringAsFixed(2)} ${Boxes().boxConversion().get('icon')}] [${category!.percentageBudget.toStringAsFixed(2)}%]:';

                    for (var expense in category.expenses) {
                      catSave +=
                          '\n${expense.expense.toStringAsFixed(2)} ${Boxes().boxConversion().get('icon')} = ${expense.expenseDetails}';
                    }
                    catSave +=
                        '\nTotal = ${category.expenseSum} ${Boxes().boxConversion().get('icon')} [${category.getUsedPercentage()}%]';
                    catSave +=
                        '\nYou ${(category.savedUp()) > 0 ? 'saved' : 'lost'} ${category.savedUp().toStringAsFixed(2)} ${Boxes().boxConversion().get('icon')}\n';
                    data += catSave;
                  }

                  writeData(data);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green[600],
                ),
                child: const Text("Save Data"),
              ),
              TextButton(
                onPressed: () async {
                  WidgetHelper().areYouSure(
                      context,
                      "You are about to delete all data, are you sure?",
                      deleteBoxes);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red[600],
                ),
                child: const Text("Delete data"),
              ),
            ]),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Account'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book),
                label: Text('Categories'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.money),
                label: Text('Expenses'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.save),
                label: Text('Data location'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          <Widget>[
            const AccountPage(),
            const CategoryPage(),
            const ExpensesPage(),
          ][navigationRailIndex],
        ],
      ),
    );
  }
}

Future<String> get _localPath async {
  const directory = 'F:\\Projects\\Flutter';

  return directory;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.txt');
}

Future<File> writeData(String data) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(data);
}
