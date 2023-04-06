import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  // METHOD = method to create the Users table
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      first_name TEXT,
      last_name TEXT,
      job_description TEXT,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
""");
  }

  // METHOD = method to be executed of our CRUD methods below, this either use Users table if already created, else create the Users table and use it
  static Future<sql.Database> db() async {
    return sql.openDatabase('./cruddb.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  // METHOD = method to insert User data to the database(Users table)
  static Future<int> createUser(
    String firstName,
    String lastName,
    String jobDescription,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'first_name': firstName,
      'last_name': lastName,
      'job_description': jobDescription
    };

    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // METHOD = method to get all users
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQLHelper.db();
    return db.query('users', orderBy: 'id');
  }

  // METHOD = method to get a specific user by ID
  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await SQLHelper.db();
    return db.query(
      'users',
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
  }

  // METHOD = method to update a user data
  static Future<int> updateUser(
    int id,
    String firstName,
    String lastName,
    String jobDescription,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'first_name': firstName,
      'last_name': lastName,
      'job_description': jobDescription
    };

    final result = await db.update(
      'users',
      data,
      where: "id = ?",
      whereArgs: [id],
    );

    return result;
  }

  // METHOD = method to delete a specific user by ID
  static Future<void> deleteUser(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(
        'users',
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}
