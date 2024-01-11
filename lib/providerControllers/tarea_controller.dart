import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/data/repositorySQlite/tarea_repository_sqlite.dart';
import 'package:task_gestor/models/tarea.model.dart';

class TareaController extends ChangeNotifier {
  final TareaRepositorySQLite repository = TareaRepositorySQLite();
  List<TareaModel> _tareas = [];

  List<TareaModel> get tareas => _tareas;

  Future<void> loadTareas() async {
    _tareas = await repository.getTareas();
    notifyListeners();
  }

  Future<void> createTarea(TareaModel tarea) async {
    await repository.createTarea(tarea);
    await loadTareas();
  }

  Future<void> seedTarea() async {
    TareaModel tarea = TareaModel(
      idProyecto: 1,
      titulo: 'Tarea1',
      fechaInicio: 'sss',
      fechaCulminacion: 'sss',
      fechaCreacion: 'ssss',
      idPrioridad: 1,
    );
    await createTarea(tarea);
    _tareas = await repository.getTareas();
    await loadTareas();
  }

  Future<void> updateTarea(TareaModel tarea) async {
    await repository.updateTarea(tarea);
    await loadTareas();
  }

  Future<void> deleteTarea(int idTarea) async {
    await repository.deleteTarea(idTarea);
    await loadTareas();
  }

  Future<TareaModel> getTareaById(int idTarea) async {
    return await repository.getTareaById(idTarea);
  }
}
