import 'package:finances/classes/boxes.class.dart';
import 'package:flutter/material.dart';

class SaveSettingsPage extends StatefulWidget {
  const SaveSettingsPage({super.key});

  @override
  State<SaveSettingsPage> createState() => _SaveSettingsPageState();
}

class _SaveSettingsPageState extends State<SaveSettingsPage> {
  final TextEditingController saveData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: <Widget>[
        TextField(
          controller: saveData,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Boxes().boxSettings().put("saveData", saveData.text);
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green[600],
          ),
          child: const Text("Save location"),
          ),
          Text(Boxes().boxSettings().get("saveData"))
      ],
    ));
  }
}
