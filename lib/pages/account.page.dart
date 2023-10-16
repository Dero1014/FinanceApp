import 'package:finances/classes/boxes.class.dart';
import 'package:flutter/material.dart';
import 'package:finances/widgets/appbar.dart';
import 'package:finances/classes/account.class.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final incomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: HomeBar("Account", false),
        body: Center(
          child: Column(children: <Widget>[
            TextField(
                controller: incomeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Money in " + Boxes().boxes[0].get("icon"),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        incomeController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ))),
            TextButton(
              onPressed: () {
                setState(() {
                  Account().setIncome(double.parse(incomeController.text));
                });
                incomeController.clear();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[600],
              ),
              child: const Text("Submit"),
            ),
            Text(Account().income.toStringAsFixed(2) + Boxes().boxes[0].get("icon")),
            Text("Saved up: " + Account().savedUp().toStringAsFixed(2) + Boxes().boxes[0].get("icon")),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
             child: Text("Back"))
          ]),
        ));
  }
}
