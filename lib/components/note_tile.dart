import 'package:flutter/material.dart';
import 'package:isar_offline_database_notes_app/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  void Function()? onEditPressed;
  void Function()? onDeletePressed;
  NoteTile(
      {super.key,
      required this.text,
      required this.onEditPressed,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
          title: Text(text),
          trailing: Builder(builder: (context) {
            return IconButton(
              onPressed: () => showPopover(
                width: 100,
                height: 100,
                backgroundColor: Theme.of(context).colorScheme.background,
                context: context,
                bodyBuilder: (context) => NoteSettings(
                  onEditTap: onEditPressed,
                  onDeleteTap: onDeletePressed,
                ),
              ),
              icon: const Icon(Icons.more_vert),
            );
          })),
    );
  }
}
