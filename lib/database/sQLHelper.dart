import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE recentItem(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        productName TEXT,
        categorySaleprice TEXT,
        mrp TEXT,
        shortdesc TEXT,
        productImage TEXT,
         productId TEXT,
        quantity TEXT,
        ecbId TEXT
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'nebula.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String productName,
      String? categorySaleprice,
      String? productImage,
      String? productId,
      String? quantity,
      String? ecbId,
      String? mrp,
      String? shortdesc) async {
    final db = await SQLHelper.db();

    final data = {
      'productName': productName,
      'categorySaleprice': categorySaleprice,
      'mrp': mrp,
      'shortdesc': shortdesc,
      'productImage': productImage,
      'productId': productId,
      'quantity': quantity,
      'ecbId': ecbId
    };
    final id = await db.insert('recentItem', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print("DatabaseId" + id.toString());
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('recentItem', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
