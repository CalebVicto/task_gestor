// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/models/tarea.model.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/ui/pages/crear_proyecto/widgets/botonera_top_nuevo.dart';
import 'package:task_gestor/ui/pages/crear_proyecto/widgets/nueva_tarea.dart';
import 'package:task_gestor/ui/widgets/snack_bar.dart';

class NuevoProyectoPage extends StatefulWidget {
  const NuevoProyectoPage({Key? key}) : super(key: key);

  @override
  State<NuevoProyectoPage> createState() => _NuevoProyectoPageState();
}

class _NuevoProyectoPageState extends State<NuevoProyectoPage> {
  final _nomProyectoController = TextEditingController();
  final _tituloTareaController = TextEditingController();
  final _fechaCreacionController = TextEditingController();
  final _fechaInicioController = TextEditingController();
  final _fechaFinalController = TextEditingController();
  final _prioridadController = TextEditingController();

  int openNuevaTarea = 0;
  int idProyecto = 0;

  void _limpiarCampos(bool _new) {
    if (_new) _nomProyectoController.clear();
    _tituloTareaController.clear();
    _fechaInicioController.clear();
    _fechaFinalController.clear();
    _prioridadController.clear();
    openNuevaTarea = 0;
  }

  void _validarYCrearProyecto() async {
    if (_nomProyectoController.text.isEmpty) {
      mostrarSnackBar(context, 'Ingrese un Nombre al Proyecto');
      return;
    }
    if (_tituloTareaController.text.isEmpty && openNuevaTarea == 1) {
      mostrarSnackBar(context, 'Ingrese el Titulo de la tarea');
      return;
    }
    if (_fechaInicioController.text.isEmpty && openNuevaTarea == 1) {
      mostrarSnackBar(context, 'Ingrese una Fecha de Inicio');
      return;
    }
    if (_fechaFinalController.text.isEmpty && openNuevaTarea == 1) {
      mostrarSnackBar(context, 'Ingrese un Fecha Final');
      return;
    }

    idProyecto = await Provider.of<ProyectoController>(context, listen: false)
        .createProyecto(
      ProyectoModel(
        idProyecto: idProyecto,
        nombreProyecto: _nomProyectoController.text,
        tareas: openNuevaTarea == 1
            ? [
                TareaModel(
                  titulo: _tituloTareaController.text,
                  fechaInicio: _fechaInicioController.text,
                  fechaCulminacion: _fechaFinalController.text,
                  fechaCreacion: _fechaCreacionController.text,
                  idPrioridad: _prioridadController.text == 'Alta'
                      ? 1
                      : _prioridadController.text == 'Media'
                          ? 2
                          : 3,
                )
              ]
            : [],
      ),
    );

    mostrarSnackBar(context, 'Proyecto/Tarea Creada con exito',
        color: Colors.green);

    setState(() => _limpiarCampos(false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BotoneraTopNuevo(
              onPressNuevo: () => _limpiarCampos(true),
              onPressGrabar: _validarYCrearProyecto,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child:
                  Text('Nombre del Proyecto', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                enabled: idProyecto == 0,
                controller: _nomProyectoController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 237, 237, 237),
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 166, 166, 166),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 5),
                Text('Registrar Tarea', style: const TextStyle(fontSize: 18)),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    openNuevaTarea = openNuevaTarea == 0 ? 1 : 0;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.add_circle_rounded,
                    size: 50,
                    color: const Color.fromARGB(255, 88, 105, 146),
                  ),
                ),
              ],
            ),
            if (openNuevaTarea == 1)
              NuevaTarea(
                nomTareaController: _tituloTareaController,
                fechaCreacionController: _fechaCreacionController,
                fechaInicioController: _fechaInicioController,
                fechaFinalController: _fechaFinalController,
                dropdownValueController: _prioridadController,
              ),
            if (openNuevaTarea == 2) Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
