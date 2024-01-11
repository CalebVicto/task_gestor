import 'package:sqflite/sqflite.dart';
import 'package:task_gestor/data/gateways/proyecto.gateway.dart';
import 'package:task_gestor/data/repositorySQlite/database_helper_sqlite.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/models/tarea.model.dart';
import 'package:path/path.dart';

class ProyectoRepositorySQLite extends ProyectoGateway {
  final DatabaseHelperSqlite _databaseHelper = DatabaseHelperSqlite();

  @override
  Future<List<ProyectoModel>> getProyectos() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> proyectosMaps =
        await db.query('proyectos');

    // Mapear proyectos
    List<ProyectoModel> proyectos =
        await Future.wait(proyectosMaps.map((map) async {
      ProyectoModel proyecto = ProyectoModel.fromJson(map);
      // Cargar tareas asociadas a este proyecto
      proyecto.tareas = await getTareasForProyecto(proyecto.idProyecto!);
      return proyecto;
    }));

    return proyectos;
  }

  Future<List<TareaModel>> getTareasForProyecto(int idProyecto) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> tareasMaps = await db.query(
      'tareas',
      where: 'idProyecto = ?',
      whereArgs: [idProyecto],
    );
    return tareasMaps.map((map) => TareaModel.fromJson(map)).toList();
  }

  @override
  Future<List<TareaModel>> getTareas(int idProyecto) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tareas',
      where: 'idProyecto = ?',
      whereArgs: [idProyecto],
    );
    return maps.map((map) => TareaModel.fromJson(map)).toList();
  }

  @override
  Future<List<TareaModel>> getTareasWithIdProyecto(int idProyecto) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tareas',
      where: 'idProyecto = ?',
      whereArgs: [idProyecto],
    );
    return maps.map((map) => TareaModel.fromJson(map)).toList();
  }

  @override
  Future<int> createProyecto(ProyectoModel proyecto) async {
    final db = await _databaseHelper.database;
    return await db.insert('proyectos', proyecto.toJson());
  }

  @override
  Future<void> updateProyecto(ProyectoModel proyecto) async {
    final db = await _databaseHelper.database;
    await db.update(
      'proyectos',
      proyecto.toJson(),
      where: 'idProyecto = ?',
      whereArgs: [proyecto.idProyecto],
    );
  }

  @override
  Future<void> deleteProyecto(int? idProyecto) async {
    if (idProyecto == null) return;
    final db = await _databaseHelper.database;
    await db.delete(
      'proyectos',
      where: 'idProyecto = ?',
      whereArgs: [idProyecto],
    );
  }

  Future<void> deleteDB() async {
    String path = join(await getDatabasesPath(), 'db_proyectos_a.db');
    await deleteDatabase(path);
    print('Database deleted.');
  }

  @override
  Future<ProyectoModel> getProyectoById(int idProyecto) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> proyectosMaps = await db.query(
      'proyectos',
      where: 'idProyecto = ?',
      whereArgs: [idProyecto],
    );

    if (proyectosMaps.isNotEmpty) {
      ProyectoModel proyecto = ProyectoModel.fromJson(proyectosMaps.first);
      proyecto.tareas = await getTareasForProyecto(proyecto.idProyecto!);
      return proyecto;
    } else {
      throw Exception('Proyecto con id $idProyecto no encontrado.');
    }
  }

  @override
  Future<void> deleteTareasPorIdProyecto(int idProyecto) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'tareas',
      where: 'idProyecto = ?',
      whereArgs: [idProyecto],
    );
  }
}
