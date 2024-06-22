import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_offline_database_notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  //initalize db
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  final List<Note> CurentNote = [];
  
  //create notes in db
  Future<void> addNotes(String userTextNote) async {
    final NewNote = Note()..text = userTextNote;

    await isar.writeTxn(() => isar.notes.put(NewNote));

    //read
    FetchNotes();
  }

  //read
  Future<void> FetchNotes() async {
    List<Note> FetcheNotes = await isar.notes.where().findAll();
    CurentNote.clear();
    CurentNote.addAll(FetcheNotes);
    notifyListeners();
  }

  //update
  Future<void> updateNotes(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await FetchNotes();
    }
  }

  //delete
  Future<void> deleteNotes(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await FetchNotes();
  }
}
