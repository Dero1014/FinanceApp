import 'package:finances/classes/category.class.dart';
import 'package:finances/pages/category.page.dart';
import 'package:finances/pages/expenses.page.dart';
import 'package:finances/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:finances/pages/account.page.dart';
import 'package:finances/pages/categoryAdd.page.dart';
import 'package:finances/pages/categoryRatio.page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'classes/account.class.dart';
import 'classes/boxes.class.dart';

void main() async {
  
  await Hive.initFlutter();

  // Open boxes
  await Boxes().openBoxes();

  initStuff();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/' : (context) => const HomePage(),
      '/expenses' :(context) => const ExpensesPage(),
      '/account' : (context) => const AccountPage(),
      '/category' : (context) => const CategoryPage(),
      '/categoryAdd' : (context) => const CategoryAddPage(),
      '/categoryRatio' : (context) => const CategoryRatioPage()
    }
  ));
}


void initStuff()
{
  Account ac = Account();
  CategoryList cl = CategoryList();
  ac.initAccount();
  cl.initList();
}

