import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_notes/data/database/notes_dao.dart';
import 'package:my_notes/data/database/notes_db.dart';
import 'package:my_notes/data/repository/notes_repository.dart';

final notesDbProvider = Provider<NotesDb>((ref) => NotesDb());
final notesDaoProvider =
    Provider<NotesDao>((ref) => NotesDao(ref.watch(notesDbProvider)));

//could be changed to future provider
final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  final notesDao = ref.watch(notesDaoProvider);
  return NotesRepository(notesDao: notesDao);
});
