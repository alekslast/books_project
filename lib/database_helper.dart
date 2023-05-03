import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'book_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'Books.db';

  static Future<Database> _getDB() async {
    return openDatabase(
      join(  // To be able to use 'join' we need to import the path
        await getDatabasesPath(),
        _dbName,
      ),
      onCreate: (db, version) async => await db.execute(  // onCreate will be called only on the
                                                          // first time. Other times 'openDatabase' will be executed.
        "CREATE TABLE Books(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NO NULL);"
      ),
      version: _version,
    );
  }


  static Future<int> addNote(Book book) async {
    final db = await _getDB();
    return await db.insert(
      'Books',
      book.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateNote(Book book) async {
    final db = await _getDB();
    return await db.update(
      'Books',
      book.toJson(),
      where: 'id = ?', whereArgs: [book.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteNote(Book book) async {
    final db = await _getDB();
    return await db.delete(
      'Books',
      where: 'id = ?', whereArgs: [book.id],
    );
  }

  // Return all the notes that we have in the DB
  static Future<List<Book>?> getAllNotes() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('Books');  // Give me whatever you have in this table

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length, (index) => Book.fromJson(maps[index])
    );
  }
}