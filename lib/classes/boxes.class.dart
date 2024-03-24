import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'category.class.dart';
import 'expenses.class.dart';

/* Boxes being used
  Account
  Categories
  Conversion
*/
class Boxes {
  List<Box> boxes = [];

  // Singleton // +
  static final Boxes _singleton = Boxes._internal();

  factory Boxes() {
    return _singleton;
  }

  Boxes._internal();
  // Singleton // -

  void registerAdapters() {
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(ExpenseAdapter());
  }

  Future<void> openBoxes() async {
    registerAdapters();

    boxes.add(await Hive.openBox("conversion"));
    boxes.add(await Hive.openBox("account"));
    boxes.add(await Hive.openBox<Category>("catagories"));
  }

  void listBoxes() async {
    String directory = (await getApplicationDocumentsDirectory()).path;
    List files;

    files = Directory(directory).listSync();
    for (var file in files) {
      //print(file);
    }
  }

  Box boxConversion() {
    return boxes[0];
  }

  Box boxAccount() {
    return boxes[1];
  }

  Box boxCategories() {
    return boxes[2];
  }
}
