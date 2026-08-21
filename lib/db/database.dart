import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/routine.dart';

class RoutineDatabase {
  static final RoutineDatabase instance = RoutineDatabase._init();
  static Database? _database;

  RoutineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('routines.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE routines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        streak INTEGER NOT NULL DEFAULT 0,
        lastDoneAt TEXT
      )
    ''');
  }

  Future<Routine> create(Routine routine) async {
    final db = await instance.database;
    final id = await db.insert('routines', routine.toMap());
    return Routine(
      id: id,
      name: routine.name,
      streak: routine.streak,
      lastDoneAt: routine.lastDoneAt,
    );
  }

  Future<List<Routine>> readAll() async {
    final db = await instance.database;
    final result = await db.query('routines', orderBy: 'id ASC');
    return result.map((json) => Routine.fromMap(json)).toList();
  }

  Future<int> complete(int id, int newStreak, DateTime now) async {
    final db = await instance.database;
    return db.update(
      'routines',
      {'streak': newStreak, 'lastDoneAt': now.toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete('routines', where: 'id = ?', whereArgs: [id]);
  }
}
