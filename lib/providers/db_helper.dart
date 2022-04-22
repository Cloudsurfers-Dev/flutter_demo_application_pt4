import 'dart:io';
import 'package:demo_application/models/persona_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  final _databaseName = "database.db";
  final _databaseVersion = 1;

  Database? _database;

  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Persone (
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            Nome TEXT NOT NULL,
            Cognome TEXT NOT NULL
          )
          ''');
  }

  Future<int> insertPersona(PersonaDB persona) async {
    if (_database == null) await _initDatabase();
    return await _database!.insert(
      "Persone",
      {
        "Nome": persona.nome,
        "Cognome": persona.cognome,
      },
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<List<PersonaDB>> listPersone() async {
    if (_database == null) await _initDatabase();
    List<PersonaDB> result = [];
    List<Map<String, Object?>> rows = await _database!.query("Persone");
    for (var row in rows) {
      result.add(PersonaDB(
        id: row["Id"] as int,
        nome: row["Nome"] as String,
        cognome: row["Cognome"] as String,
      ));
    }
    return result;
  }

  Future<int> deletePersona(PersonaDB persona) async {
    if (_database == null) await _initDatabase();
    return await _database!.delete(
      "Persone",
      where: "Id = ?",
      whereArgs: [persona.id],
    );
  }
}
