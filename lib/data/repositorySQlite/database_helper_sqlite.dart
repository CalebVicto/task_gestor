import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperSqlite {
  static final DatabaseHelperSqlite _instance = DatabaseHelperSqlite._();
  static Database? _database;

  DatabaseHelperSqlite._();

  factory DatabaseHelperSqlite() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'db_proyectos_c.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE proyectos(
        idProyecto INTEGER PRIMARY KEY AUTOINCREMENT,
        idUsuario INTEGER,
        nombreProyecto TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tareas(
        idTarea INTEGER PRIMARY KEY AUTOINCREMENT,
        idProyecto INTEGER,
        titulo TEXT,
        fechaInicio TEXT,
        fechaCulminacion TEXT,
        idPrioridad INTEGER,
        fechaCreacion TEXT
      )
    ''');
    print('Tablas creadas correctamente.');
  }
}
