import 'package:finances/classes/widgethelper.class.dart';
import 'package:finances/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../classes/boxes.class.dart';
import '../classes/category.class.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void nothin() {}

  void deleteBoxes()
  {
    Boxes().boxAccount().clear();
    Boxes().boxCategories().clear();
    Boxes().boxConversion().clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar("Home", true),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/category");
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[600],
              ),
              child: const Text("Category"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/account");
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[600],
              ),
              child: const Text("Account"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/expenses");
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[600],
              ),
              child: const Text("Expenses"),
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
            // This is all about excel
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
            )
          ],
        ),
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();

  return directory!.path;
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
