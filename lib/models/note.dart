import 'package:isar/isar.dart';
part 'note.g.dart';//is a generated file that contains the Isar schema for the Note collection.

@Collection()// annotation indicates that this class is a collection in the database.
class Note {
  Id id = Isar.autoIncrement;//that is automatically incremented by Isar when a new note is inserted.
  late String text;
}

