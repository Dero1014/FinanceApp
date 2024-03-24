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
    return const Expanded(
      child: Row(
        children: <Widget>[
          CategoryAddPage(),
          VerticalDivider(),
          CategoryRatioPage()
        ],
      ),
    );
  }
}