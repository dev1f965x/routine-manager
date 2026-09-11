import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/routine.dart';

/// Local SQLite storage for routines.
class RoutineDatabase {
  RoutineDatabase._();

  static final instance = RoutineDatabase._();

  static const _table = 'routines';

  late final Future<Database> _database = _open();

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'routines.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) => db.execute('''
        CREATE TABLE $_table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          streak INTEGER NOT NULL DEFAULT 0,
          lastDoneAt TEXT
        )
      '''),
    );
  }

  Future<List<Routine>> readAll() async {
    final rows = await (await _database).query(_table, orderBy: 'id ASC');
    return rows.map(Routine.fromMap).toList();
  }

  Future<void> insert(Routine routine) async {
    await (await _database).insert(_table, routine.toMap()..remove('id'));
  }

  Future<void> update(Routine routine) async {
    await (await _database).update(
      _table,
      routine.toMap(),
      where: 'id = ?',
      whereArgs: [routine.id],
    );
  }

  Future<void> delete(int id) async {
    await (await _database).delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
