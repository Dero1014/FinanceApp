import 'package:flutter/material.dart';


class HomeBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  HomeBar(this.title);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title), backgroundColor: Colors.grey, centerTitle: true);
  }
}
