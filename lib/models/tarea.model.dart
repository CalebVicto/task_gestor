class TareaModel {
  late int? idTarea;
  late int? idProyecto = 0;
  late int? idPrioridad;
  late String titulo;
  late String fechaInicio;
  late String fechaCulminacion;
  late String? fechaCreacion;
  bool selected = false;

  TareaModel({
    this.idTarea,
    this.idProyecto,
    this.idPrioridad,
    required this.titulo,
    required this.fechaInicio,
    required this.fechaCulminacion,
    this.fechaCreacion,
  });

  TareaModel.fromJson(Map<String, dynamic> json) {
    idTarea = json['idTarea'];
    titulo = json['titulo'];
    fechaInicio = json['fechaInicio'];
    fechaCulminacion = json['fechaCulminacion'];
    idPrioridad = json['idPrioridad'];
    fechaCreacion = json['fechaCreacion'];
    idProyecto = json['idProyecto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idProyecto'] = idProyecto;
    data['idPrioridad'] = idPrioridad;
    data['titulo'] = titulo;
    data['fechaInicio'] = fechaInicio;
    data['fechaCulminacion'] = fechaCulminacion;
    data['fechaCreacion'] = fechaCreacion;
    return data;
  }
}
