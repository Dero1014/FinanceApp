import 'package:finances/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:finances/classes/category.class.dart';
import 'package:finances/widgets/categoryCards.widget.dart';

class CategoryRatioPage extends StatefulWidget {
  const CategoryRatioPage({super.key});

  @override
  State<CategoryRatioPage> createState() => _CategoryRatioPageState();
}

class _CategoryRatioPageState extends State<CategoryRatioPage> {
  bool visible = false;
  var categoryList = CategoryList();

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    getPercentageInfo();
  }

  void getPercentageInfo() {
    double sum = 0;
    for (var i = 0; i < categoryList.categories.length; i++) {
      sum += categoryList.categories[i].percentage;

      setState(() {
        if (sum > 100) {
          visible = true;
        } else {
          visible = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: catListNotif,
      builder: (context, value, child) {
        return Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: categoryList.categories.length,
                    itemBuilder: (context, index) {
                      return CategoryRatioCard(
                          category: categoryList.categories[index],
                          visibleFunc: getPercentageInfo);
                    }),
              ),
              Visibility(
                visible: visible,
                child: const Text(
                  'You are over 100%',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      },
    );
  }
}
