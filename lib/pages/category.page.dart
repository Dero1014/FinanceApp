import 'package:flutter/material.dart';
import 'categoryAdd.page.dart';
import 'categoryRatio.page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Categories"),
          centerTitle: true,
          backgroundColor: Colors.grey,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.add)),
              Tab(icon: Icon(Icons.align_horizontal_left))
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CategoryAddPage(),
            CategoryRatioPage()
          ],
        ),
      )
    );
  }
}