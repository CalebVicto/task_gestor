import 'package:task_gestor/models/tarea.model.dart';

abstract class TareaGateway {
  Future<List<TareaModel>> getTareas();
  Future<List<TareaModel>> searchAllTarea(String txtBusqueda);

  // crud
  void createTarea(TareaModel tarea);
  void updateTarea(TareaModel tarea);
  Future<TareaModel> getTareaById(int idTarea);
  void deleteTarea(int idTarea);
}
