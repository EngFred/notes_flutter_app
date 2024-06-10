import 'package:drift/drift.dart';

//notes table
class Note extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 3, max: 50).nullable()();
  TextColumn get description => text()();
  BoolColumn get starred => boolean()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get color => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
