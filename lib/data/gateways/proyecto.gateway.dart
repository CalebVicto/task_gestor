import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/models/tarea.model.dart';

abstract class ProyectoGateway {
  Future<List<ProyectoModel>> getProyectos();
  Future<List<TareaModel>> getTareasWithIdProyecto(int idProyecto);
  Future<List<TareaModel>> getTareas(int idProyecto);

  // crud
  Future<void> createProyecto(ProyectoModel proyecto);
  Future<void> updateProyecto(ProyectoModel proyecto);
  Future<ProyectoModel> getProyectoById(int idProyecto);
  Future<void> deleteProyecto(int idProyecto);
  Future<void> deleteTareasPorIdProyecto(int idProyecto);
}
