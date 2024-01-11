// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:provider/provider.dart';
import 'package:task_gestor/data/repositorySQlite/proyecto_respository_sqlite.dart';
import 'package:task_gestor/data/repositorySQlite/tarea_repository_sqlite.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:task_gestor/models/tarea.model.dart';

class ProyectoController extends ChangeNotifier {
  final ProyectoRepositorySQLite repository = ProyectoRepositorySQLite();
  List<ProyectoModel> _proyectos = [];
  Map<String, int> _selectedItems = {"idProyecto": 0, "idTarea": 0};

  List<ProyectoModel> get proyectos => _proyectos;
  Map<String, int> get selectedItems => _selectedItems;
  set selectedItems(Map<String, int> items) => _selectedItems = items;

  Future<List<ProyectoModel>> loadProyectos() async {
    _proyectos = await repository.getProyectos();
    notifyListeners();
    return _proyectos;
  }

  Future<int> createProyecto(ProyectoModel proyecto) async {
    int res = 0;

    // Crea el proyecto solo si no tiene un ID
    if (proyecto.idProyecto == 0) {
      res = await repository.createProyecto(proyecto);
    } else {
      // Si el proyecto ya tiene un ID, usa ese ID
      res = proyecto.idProyecto!;
    }

    // Inserta tareas si existen
    if (proyecto.tareas!.isNotEmpty) {
      final TareaRepositorySQLite repositoryTarea = TareaRepositorySQLite();

      for (var tarea in proyecto.tareas!) {
        if (tarea != null) {
          tarea.idProyecto = res;
          await repositoryTarea.createTarea(tarea);
        }
      }
    }

    // Devuelve el resultado (ID del proyecto)
    return res;
  }

  Future<void> updateProyecto(ProyectoModel proyecto) async {
    await repository.updateProyecto(proyecto);
    await loadProyectos();
  }

  Future<void> deleteItemsSelected() async {
    if (_proyectos.isEmpty) return;

    for (var proyecto in _proyectos) {
      if (proyecto.selected) {
        await repository.deleteTareasPorIdProyecto(proyecto.idProyecto!);
        await repository.deleteProyecto(proyecto.idProyecto!);
      } else {
        for (var tarea in proyecto.tareas!) {
          if (tarea!.selected) {
            final TareaRepositorySQLite repositoryTarea =
                TareaRepositorySQLite();
            repositoryTarea.deleteTarea(tarea.idTarea!);
          }
        }
      }
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> deleteProyecto(int idProyecto) async {
    await repository.deleteProyecto(idProyecto);
    await loadProyectos();
  }

  Future<List<TareaModel>> getTareasForProyecto(int idProyecto) async {
    return await repository.getTareas(idProyecto);
  }

  Future<ProyectoModel> getProyectoById(int idProyecto) async {
    return await repository.getProyectoById(idProyecto);
  }

  // ! --------------- METODOS LOCALES
  set proyectos(List<ProyectoModel> data) {
    _proyectos = data;
    notifyListeners();
  }

  // ? SELECCIONAR TODOS
  void seleccionarTodos(bool stateCheck) {
    if (_proyectos.isEmpty) return;
    for (var proyecto in _proyectos) {
      proyecto.selected = stateCheck;
      if (proyecto.tareas != null) {
        for (var tarea in proyecto.tareas!) {
          tarea?.selected = stateCheck;
        }
      }
    }
    // tareaEstaSeleccionada();
    notifyListeners();
  }

  // ? --- SELECCIONAR UN PROYECTO
  void seleccionarProyecto(int idProyecto, bool stateCheck) {
    if (_proyectos.isEmpty) return;
    final proyecto =
        _proyectos.firstWhereOrNull((p) => p.idProyecto == idProyecto);
    if (proyecto == null) return;
    proyecto.selected = stateCheck;
    // if (proyecto.tareas != null)
    //   for (var tarea in proyecto.tareas!) tarea?.selected = stateCheck;
    tareaEstaSeleccionada();
    notifyListeners();
  }

  // ? --- SELECCIONAR TAREA
  void seleccionarTarea(int idTarea, bool stateCheck) {
    if (_proyectos.isEmpty) return;
    final tarea = _proyectos
        .expand((p) => p.tareas ?? [])
        .firstWhereOrNull((t) => t?.idTarea == idTarea);
    tarea?.selected = stateCheck;
    tareaEstaSeleccionada();
    notifyListeners();
  }

  // ? --- VERIFICIAR LAS TAREAS SELCCIONADAS
  void tareaEstaSeleccionada() {
    if (_proyectos.isEmpty) {
      _selectedItems = {"idProyecto": 0, "idTarea": 0};
      return;
    }

    int? idProyecto = 0;
    int idTarea = 0;
    int cambio = 0;

    for (var proyecto in _proyectos) {
      if (proyecto.selected) {
        if (cambio == 1) {
          // Hay más de un proyecto seleccionado, reiniciar selección
          _selectedItems = {"idProyecto": 0, "idTarea": 0};
          return;
        }
        idProyecto = proyecto.idProyecto;
        cambio = 1;
      }

      if (proyecto.tareas != null) {
        for (var tarea in proyecto.tareas!) {
          if (tarea?.selected ?? false) {
            if (cambio == 1) {
              // Hay más de un proyecto seleccionado, reiniciar selección
              _selectedItems = {"idProyecto": 0, "idTarea": 0};
              return;
            }
            idTarea = tarea?.idTarea ?? 0;
            cambio = 1;
          }
        }
      }

      if (cambio == 2) {
        break;
      }
    }

    _selectedItems = {"idProyecto": idProyecto ?? 0, "idTarea": idTarea};
  }
}
