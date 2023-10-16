import 'package:finances/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../classes/category.class.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void nothin()
  {

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
                var box1 = Hive.box("account");
                var box2 = Hive.box<Category>("catagories");
                var box3 = Hive.box("Conversion");;


                box1.clear();
                box2.clear();
                box3.clear();
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
                //var box1 = Hive.box("account");
                var box2 = Hive.box<Category>("catagories");
                //var excel = Excel.createExcel();
                String data = "";
                //print("Saving file");
                for (var i = 0; i < box2.length; i++) {
                  var category = box2.getAt(i);
                  String catSave = '\n${category!.name}:\n';

                  for (var j = 0; j < category.expenses.length; j++) {
                    catSave += '\n${category.expenses[j].expense} kn = ${category.expenses[j].expenseDetails}';
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