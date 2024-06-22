import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_offline_database_notes_app/components/drawer.dart';
import 'package:isar_offline_database_notes_app/components/note_tile.dart';
import 'package:isar_offline_database_notes_app/models/note.dart';
import 'package:isar_offline_database_notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //on app startup featch existing notes
    readNotes();
  }

  // create
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              //add to db
              context.read<NoteDatabase>().addNotes(textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text("create"),
          ),
        ],
      ),
    );
  }

  //update

  void update(Note note) {
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text("update note"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .updateNotes(note.id, textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("update"),
                )
              ],
            ));
  }
  // delete

  void delete(int id) {
    context.read<NoteDatabase>().deleteNotes(id);
    
  }
  //read

  void readNotes() {
    context.read<NoteDatabase>().FetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> curentNotes = noteDatabase.CurentNote;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: createNote,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "Notes",
            style: GoogleFonts.dmSerifText(
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: curentNotes.length,
            itemBuilder: (context, index) {
              final note = curentNotes[index];
              return NoteTile(
                text: note.text,
                onEditPressed: () => update(note),
                onDeletePressed: () => delete(note.id),
              );
            },
          ),
        ),
      ]),
    );
  }
}
