import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  void Function()? onTap;
  MyListTile(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text , style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),),
        onTap: onTap,
      ),
    );
  }
}
