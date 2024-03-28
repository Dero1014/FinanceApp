import 'package:finances/classes/account.class.dart';
import 'package:finances/classes/boxes.class.dart';
import 'package:flutter/material.dart';
import 'package:finances/classes/category.class.dart';

import '../classes/widgethelper.class.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Function() delete;

  const CategoryCard({super.key, required this.category, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category.name,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
              ),
            ),
            IconButton(
              onPressed: () {
                WidgetHelper().areYouSure(context, "You are about to delete a category, are you sure?", delete);
              },
              icon: Icon(Icons.delete, color: Colors.red[300]),
            )
          ],
        ),
      ),
    );
  }
}

///------------------Category Ratio card---------------------/// 

class CategoryRatioCard extends StatefulWidget {
  final Category category;
  final Function visibleFunc;

  const CategoryRatioCard(
      {super.key, required this.category, required this.visibleFunc});

  @override
  State<CategoryRatioCard> createState() => _CategoryRatioCardState();
}

class _CategoryRatioCardState extends State<CategoryRatioCard> {
  Account ac = Account();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              WidgetHelper().maxStringAllowed(widget.category.name),
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Slider(
                    value: widget.category.percentageBudget,
                    max: 100,
                    min: 0,
                    divisions: 100,
                    label: widget.category.percentageBudget.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        widget.visibleFunc();
                        widget.category.changePercentage(value);
                      });
                    }),
                Text("${widget.category.percentageBudget.round()}%" ),
                Text((ac.income * (widget.category.percentageBudget) / 100)
                    .toStringAsFixed(2) +
                Boxes().boxes[0].get("icon"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
