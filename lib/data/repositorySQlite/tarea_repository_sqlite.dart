import 'package:sqflite/sqflite.dart';
import 'package:task_gestor/data/gateways/tarea.gatewat.dart';
import 'package:task_gestor/data/repositorySQlite/database_helper_sqlite.dart';
import 'package:task_gestor/models/tarea.model.dart';

class TareaRepositorySQLite extends TareaGateway {
  final DatabaseHelperSqlite _databaseHelper = DatabaseHelperSqlite();

  @override
  Future<void> createTarea(TareaModel tarea) async {
    final db = await _databaseHelper.database;
    await db.insert('tareas', tarea.toJson());
  }

  @override
  Future<void> deleteTarea(int idTarea) async {
    final db = await _databaseHelper.database;
    await db.delete('tareas', where: 'idTarea = ?', whereArgs: [idTarea]);
  }

  @override
  Future<List<TareaModel>> getTareas() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('tareas');
    return maps.map((map) => TareaModel.fromJson(map)).toList();
  }

  @override
  Future<List<TareaModel>> searchAllTarea(String txtBusqueda) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tareas',
      where: 'titulo LIKE ?',
      whereArgs: ['%$txtBusqueda%'],
    );
    return maps.map((map) => TareaModel.fromJson(map)).toList();
  }

  @override
  Future<void> updateTarea(TareaModel tarea) async {
    final db = await _databaseHelper.database;
    await db.update(
      'tareas',
      tarea.toJson(),
      where: 'idTarea = ?',
      whereArgs: [tarea.idTarea],
    );
  }

  @override
  Future<TareaModel> getTareaById(int idTarea) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> tareasMaps = await db.query(
      'tareas',
      where: 'idTarea = ?',
      whereArgs: [idTarea],
    );

    if (tareasMaps.isNotEmpty) {
      TareaModel tarea = TareaModel.fromJson(tareasMaps.first);
      return tarea;
    } else {
      throw Exception('Proyecto con id $idTarea no encontrado.');
    }
  }
}
