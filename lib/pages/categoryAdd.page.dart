import 'package:flutter/material.dart';
import 'package:finances/classes/category.class.dart';
import 'package:finances/widgets/categoryCards.widget.dart';

class CategoryAddPage extends StatefulWidget {
  const CategoryAddPage({super.key});

  @override
  State<CategoryAddPage> createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends State<CategoryAddPage> {
  final categoryTextControler = TextEditingController();

  var categoryList = CategoryList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: <Widget>[
        TextField(
            controller: categoryTextControler,
            decoration: InputDecoration(
                hintText: "Gib me a category..",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    //Clear text from input
                    categoryTextControler.clear();
                  },
                  icon: const Icon(Icons.clear),
                ))),
        TextButton(
          onPressed: () {
            if (categoryTextControler.text == "") {
              // print("Empty");
              return;
            }
            for (var i = 0; i < categoryList.categories.length; i++) {
              if (categoryList.categories[i].name ==
                  categoryTextControler.text) {
                // print("exists");
                categoryTextControler.clear();
                return;
              }
            }
            categoryList.addToList(categoryTextControler.text);
            setState(() {});
            categoryTextControler.clear();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[600],
          ),
          child: const Text("Submit"),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: categoryList.categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                      category: categoryList.categories[index],
                        delete: ((() {
                        setState(() {
                          // print("removed category");
                          categoryList
                              .removeFromList(index);
                        });
                      })));
                }))
      ]),
    ));
  }
}
