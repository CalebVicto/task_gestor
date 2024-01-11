import 'package:task_gestor/models/tarea.model.dart';

class ProyectoModel {
  late int? idProyecto;
  late String nombreProyecto;
  late int idUsuario = 1;
  List<TareaModel?>? tareas;
  bool selected = false;

  ProyectoModel({
    this.idProyecto,
    required this.nombreProyecto,
    this.tareas,
  });

  ProyectoModel.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    idProyecto = json['idProyecto'];
    nombreProyecto = json['nombreProyecto'];
    if (json['tareas'] != null) {
      tareas = <TareaModel>[];
      json['tareas'].forEach((v) {
        tareas!.add(TareaModel.fromJson(v));
      });
    }
  }

  void changeSelected() => selected = !selected;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUsuario'] = idUsuario;
    data['nombreProyecto'] = nombreProyecto;
    // data['tareas'] = tareas?.map((v) => v?.toJson()).toList();
    return data;
  }
}
