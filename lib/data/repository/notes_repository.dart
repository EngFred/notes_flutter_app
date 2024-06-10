import 'package:logger/logger.dart';
import 'package:my_notes/data/database/notes_dao.dart';
import 'package:my_notes/data/database/notes_db.dart';

class NotesRepository {
  final NotesDao _notesDao;

  NotesRepository({required NotesDao notesDao}) : _notesDao = notesDao;

  Stream<List<NoteData>> loadNotes() {
    // try {
    //   return await _notesDao.getAllNotes();
    // } catch (err) {
    //   Logger().i("Error getting notes! $err");
    //   return null;
    // }
    return _notesDao.getAllNotes();
  }

  Future<void> addNote(NoteData note) async {
    Logger().d("Saving a note...");
    await _notesDao.insertNote(note);
    Logger().i("Note saved successfully!");
    // try {
    //   Logger().d("Saving a note...");
    //   await _notesDao.insertNote(note);
    //   Logger().i("Note saved successfully!");
    // } catch (err) {
    //   Logger().i("Error adding a note! $err");
    // }
  }

  Future<void> updateNote(NoteData note) async {
    Logger().d("Updating note...");
    await _notesDao.updateNote(note);
    Logger().d("Note updated successfully!");
  }

  Future<void> deleteNote(NoteData note) async {
    try {
      await _notesDao.deleteNote(note);
    } catch (err) {
      Logger().i("Error deleting a note! $err");
    }
  }

  Future<NoteData?> getNoteById(String id) async {
    try {
      return await _notesDao.getNoteById(id);
    } catch (err) {
      Logger().i("Error fetching a note! $err");
      return null;
    }
  }
}
