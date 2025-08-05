import 'package:conservation_data/models/catch_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sprintf/sprintf.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._instance();
  static Database? _database;

  LocalDatabase._instance();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'local.db');
    logger.d(sprintf('INITIALIZING LOCAL DATABASE AT `%s`.', [path]));
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Catches (
        uuid TEXT PRIMARY KEY NOT NULL,
        length FLOAT NOT NULL,
        weight FLOAT NOT NULL,
        girth FLOAT,
        datetime TEXT NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> insertCatch(CatchEntry entry) async {
    final db = await instance.database;
    return await db.insert('Catches', entry.toMap());
  }

  Future<List<Map<String, dynamic>>> getCatchByUuid(String uuid) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM Catches WHERE uuid = ?', [uuid]);
  }

  Future<List<Map<String, dynamic>>> readAllCatches() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM Catches');
  }

  Future<int> updateCatch(CatchEntry entry) async {
    Database db = await instance.database;
    return await db.update(
      'Catches', 
      entry.toMap(), 
      where: 'uuid = ?',
      whereArgs: [entry.uuid],
    );
  }
}