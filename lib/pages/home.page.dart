import 'package:finances/classes/account.class.dart';
import 'package:finances/classes/widgethelper.class.dart';
import 'package:finances/pages/account.page.dart';
import 'package:finances/pages/category.page.dart';
import 'package:finances/pages/categoryAdd.page.dart';
import 'package:finances/pages/categoryRatio.page.dart';
import 'package:finances/pages/expenseAdd.page.dart';
import 'package:finances/pages/expenseView.page.dart';
import 'package:finances/pages/expenses.page.dart';
import 'package:finances/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../classes/boxes.class.dart';
import '../classes/category.class.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MyNotifier extends ValueNotifier<CategoryList>
{
  MyNotifier(CategoryList value) : super(value);

  void dataChanged()
  {
    notifyListeners();
  }
}

final MyNotifier catListNotif = new MyNotifier(CategoryList());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.selected;
  double groupAlignment = -1;
  void nothin() {}

  void deleteBoxes() {
    Boxes().boxAccount().clear();
    Boxes().boxCategories().clear();
    Boxes().boxConversion().clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar("Home", true),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: groupAlignment,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: labelType,
            useIndicator: true,
            indicatorColor: Colors.amber,
            trailing: Column(children: <Widget>[
              TextButton(
              onPressed: () async {
                var box2 = Hive.box<Category>("catagories");
                String data = "";
                for (var i = 0; i < box2.length; i++) {
                  var category = box2.getAt(i);
                  String catSave = '\n${category!.name}:\n';
                  for (var j = 0; j < category.expenses.length; j++) {
                    catSave +=
                        '\n${category.expenses[j].expense} kn = ${category.expenses[j].expenseDetails}';
                  }
                  catSave += '\nTotal = ${category.expenseSum}\n';
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
                WidgetHelper().areYouSure(context, "You are about to delete all data, are you sure?", deleteBoxes);
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
                label: Text('First'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book),
                label: Text('Second'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.money),
                label: Text('Third'),
              ),
            ],
          ),
          VerticalDivider( thickness: 1, width: 1),
          <Widget>[
              AccountPage(),
              CategoryPage(),
              ExpensesPage(),
            ][_selectedIndex],
        ],
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = 'F:\\Projects\\Flutter';

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