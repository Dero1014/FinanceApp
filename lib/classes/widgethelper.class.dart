// Contains functions to be used in widgets or similar

import 'package:flutter/material.dart';

class WidgetHelper {
  // Singleton // +
  static final WidgetHelper _singleton = WidgetHelper._internal();

  factory WidgetHelper() {
    return _singleton;
  }

  WidgetHelper._internal();
  // Singleton // -

  // Helper functions
  String maxStringAllowed(String text) {
    String result = text;
    int maxStringLength = 12;

    if (result.length >= maxStringLength) {
      result = result.substring(0, maxStringLength);
      result += "...";
    }

    return result;
  }

  void areYouSure(BuildContext context, String statement, Function yesFunc) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(statement),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
                TextButton(
                  onPressed: () {
                    yesFunc();
                    Navigator.pop(context);
                  },
                  child: Text("Yes"),
                )
              ],
            ));
  }
}
