import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  void Function()? onEditTap;
  void Function()? onDeleteTap;
  NoteSettings({super.key, required this.onEditTap, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
              onEditTap!();
            },
            child: Container(
              height: 30,
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "Edit",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
              onDeleteTap!();
            },
            child: Container(
              height: 30,
              color: Theme.of(context).colorScheme.background,
              child: Center(
                  child: Text(
                "Delete",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              )),
            )),
      ],
    );
  }
}
