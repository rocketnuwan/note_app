import 'package:note_app/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlHelper {
  //create Database
  static Future<Database> initDB() async {
    //storig DB in the device
    //on android data
    //on ios documents
    final dbPath = await getDatabasesPath();

    //best practies
    final path = join(dbPath, 'notes.db');

    return openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await createTables(database);
    });
  }

  //create tables
  static Future<void> createTables(Database database) async {
    await database.execute("""

          CREATE TABLE Notes (
	          id INTEGER PRIMARY KEY AUTOINCREMENT,
	          title TEXT,
	          description TEXT,
	          createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )

        """);
  }

  //insert note
  static Future<void> createNote(String title, String desc) async {
    final db = await initDB();

    final data = {'title': title, 'description': desc};

    await db.insert(
      'Notes',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //read all note from table
  static Future<List<NoteModel>> getNotes() async {
    final db = await initDB();

    //fetch notes
    final result = await db.query('Notes', orderBy: 'id');

    //mapping fetch data to notes model and return
    return result.map((e) => NoteModel.fromJson(e)).toList();
  }

//update notes
  static Future<int> updateNote(int id, String title, String desc) async {
    final db = await initDB();

    final data = {
      'title': title,
      'description': desc,
      'createdAt': DateTime.now().toString()
    };

    final rId = await db.update(
      'Notes',
      data,
      where: "id=?",
      whereArgs: [id],
    );
    return rId;
  }

  static Future<void> deleteNote(int id) async {
    final db = await initDB();

    await db.delete(
      'Notes',
      where: "id=?",
      whereArgs: [id],
    );
  }
}
