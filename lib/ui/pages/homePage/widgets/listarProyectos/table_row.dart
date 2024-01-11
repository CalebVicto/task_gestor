// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/models/tarea.model.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/listarProyectos/table_celda.dart';

class RowTable extends StatefulWidget {
  final ProyectoModel proyecto;
  const RowTable({super.key, required this.proyecto});

  @override
  State<RowTable> createState() => _RowTableState();
}

class _RowTableState extends State<RowTable> {
  Color bkgCeldaHeader = const Color.fromARGB(255, 222, 235, 247);
  Color txtCeldaHeader = const Color.fromARGB(255, 69, 111, 186);
  bool isSelected = false;
  bool isSelectedProyect = false;

  @override
  Widget build(BuildContext context) {
    ProyectoModel proyecto = widget.proyecto;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        // ? ----- NOMBRE DEL PROYECTO
        nombreDelProyecto(width, proyecto),
        // ? ----- TAREAS
        ...(listarTareas().toList()),
        SizedBox(height: 15)
      ],
    );
  }

  List<Widget> listarTareas() {
    List<TareaModel?>? tareas = widget.proyecto.tareas;
    if (tareas == null) return [];
    return tareas.map((tarea) {
      if (tarea == null) return Container();
      return Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: Transform.scale(
              scale: 2.2,
              child: Checkbox(
                value: tarea.selected,
                onChanged: (val) {
                  Provider.of<ProyectoController>(context, listen: false)
                      .seleccionarTarea(tarea.idTarea!, val!);
                  setState(() {});
                },
              ),
            ),
          ),
          TableCelda(
            bkgCelda: bkgCeldaHeader,
            txtCelda: tarea.titulo.toString(),
            txtColor: txtCeldaHeader,
            widthCelda: 160,
          ),
          TableCelda(
            bkgCelda: bkgCeldaHeader,
            txtCelda: tarea.fechaInicio.toString(),
            txtColor: txtCeldaHeader,
            widthCelda: 100,
          ),
          TableCelda(
            bkgCelda: bkgCeldaHeader,
            txtCelda: tarea.idPrioridad == 1
                ? 'Alta'
                : tarea.idPrioridad == 2
                    ? 'Media'
                    : 'Baja',
            txtColor: txtCeldaHeader,
            widthCelda: 100,
          ),
          TableCelda(
            bkgCelda: bkgCeldaHeader,
            txtCelda: tarea.fechaCulminacion.toString(),
            txtColor: txtCeldaHeader,
            widthCelda: 110,
          ),
          TableCelda(
            bkgCelda: bkgCeldaHeader,
            txtCelda: tarea.fechaCreacion.toString(),
            txtColor: txtCeldaHeader,
            widthCelda: 100,
          ),
        ],
      );
    }).toList();
  }

  SizedBox nombreDelProyecto(double width, ProyectoModel proyecto) {
    return SizedBox(
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(6, 1, 4, 0),
            child: Transform.scale(
              scale: 2.2,
              child: Checkbox(
                value: proyecto.selected,
                onChanged: (val) {
                  Provider.of<ProyectoController>(context, listen: false)
                      .seleccionarProyecto(proyecto.idProyecto!, val!);
                  setState(() {});
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, top: 2, bottom: 2),
            width: width,
            color: const Color.fromARGB(255, 230, 254, 231),
            child: Text(
              textAlign: TextAlign.start,
              "#${proyecto.idProyecto} - ${proyecto.nombreProyecto}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          proyecto.tareas?.length == 0
              ? SizedBox(width: width * 0.35)
              : Container(),
        ],
      ),
    );
  }
}
