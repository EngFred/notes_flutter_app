import 'package:drift/drift.dart';
import 'package:my_notes/data/database/notes_db.dart';
import 'package:my_notes/domain/models/note.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [Note])
class NotesDao extends DatabaseAccessor<NotesDb> with _$NotesDaoMixin {
  final NotesDb database;
  NotesDao(this.database) : super(database);

  //Future<List<NoteData>> getAllNotes() => select(note).get();
  Stream<List<NoteData>> getAllNotes() => select(note).watch();
  Future<int> insertNote(NoteData theNote) => into(note).insert(theNote);
  Future<bool> updateNote(NoteData theNote) => update(note).replace(theNote);
  Future<int> deleteNote(NoteData theNote) => delete(note).delete(theNote);

  Future<NoteData?> getNoteById(String id) {
    return (select(note)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
