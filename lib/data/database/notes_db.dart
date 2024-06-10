import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:my_notes/data/database/notes_dao.dart';
import 'package:my_notes/domain/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'notes_db.g.dart';

@DriftDatabase(tables: [Note], daos: [NotesDao])
class NotesDb extends _$NotesDb {
  NotesDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
