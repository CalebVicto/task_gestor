// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/models/tarea.model.dart';
import 'package:task_gestor/providerControllers/page_router_controller.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/providerControllers/tarea_controller.dart';
import 'package:task_gestor/ui/pages/crear_proyecto/widgets/botonera_top_nuevo.dart';
import 'package:task_gestor/ui/pages/crear_proyecto/widgets/nueva_tarea.dart';
import 'package:task_gestor/ui/widgets/snack_bar.dart';

class EditarProyectoPage extends StatefulWidget {
  const EditarProyectoPage({Key? key}) : super(key: key);

  @override
  State<EditarProyectoPage> createState() => _EditarProyectoPageState();
}

class _EditarProyectoPageState extends State<EditarProyectoPage> {
  final _nomProyectoController = TextEditingController();
  final _tituloTareaController = TextEditingController();
  final _fechaCreacionController = TextEditingController();
  final _fechaInicioController = TextEditingController();
  final _fechaFinalController = TextEditingController();
  final _prioridadController = TextEditingController();

  int openNuevaTarea = 0;
  int idProyecto = 0;

  @override
  void initState() {
    super.initState();
    _cargarInfoProyecto();
  }

  void _cargarInfoProyecto() async {
    ProyectoController proyectoController =
        Provider.of<ProyectoController>(context, listen: false);
    TareaController tareaController =
        Provider.of<TareaController>(context, listen: false);

    idProyecto = proyectoController.selectedItems["idProyecto"] ?? 0;

    if (proyectoController.selectedItems["idTarea"] == 0) {
      // Si el elemento seleccionado es un Proyecto
      ProyectoModel proyecto =
          await proyectoController.getProyectoById(idProyecto);

      _nomProyectoController.text = proyecto.nombreProyecto;

      setState(() {});
    } else {
      print('EditarTarea');

      TareaModel tarea = await tareaController
          .getTareaById(proyectoController.selectedItems["idTarea"]!);

      // --- Validar que el idProyecto no se 0
      if (tarea.idTarea == null || tarea.idTarea == 0) {
        final indexPage =
            Provider.of<PageRouterController>(context, listen: false);
        indexPage.index = 1;
        return;
      }

      // --- Abirr el formulario
      openNuevaTarea = 1;

      // --- Insertar DatosTareaActual
      _tituloTareaController.text = tarea.titulo;
      _fechaInicioController.text = tarea.fechaInicio;
      _fechaFinalController.text = tarea.fechaCulminacion;
      _prioridadController.text = tarea.idPrioridad == 1
          ? 'Alta'
          : tarea.idPrioridad == 2
              ? 'Media'
              : 'Baja';
      //  ---- Datos proyecto
      idProyecto = tarea.idProyecto ?? 0;

      ProyectoModel proyecto =
          await proyectoController.getProyectoById(idProyecto);
      _nomProyectoController.text = proyecto.nombreProyecto;

      setState(() {});
    }
  }

  void _limpiarCampos(bool _new) {
    if (_new) _nomProyectoController.clear();
    _tituloTareaController.clear();
    _fechaInicioController.clear();
    _fechaFinalController.clear();
    _prioridadController.clear();
    openNuevaTarea = 0;
  }

  void _validarYCrearProyecto() async {
    final nomProyecto = _nomProyectoController.text;
    final tituloTarea = _tituloTareaController.text;
    final fechaInicio = _fechaInicioController.text;
    final fechaFinal = _fechaFinalController.text;
    final prioridad = _prioridadController.text;

    if (nomProyecto.isEmpty) {
      mostrarSnackBar(context, 'Ingrese un Nombre al Proyecto');
      return;
    }
    if (tituloTarea.isEmpty && openNuevaTarea == 1) {
      mostrarSnackBar(context, 'Ingrese el Titulo de la tarea');
      return;
    }
    if (fechaInicio.isEmpty && openNuevaTarea == 1) {
      mostrarSnackBar(context, 'Ingrese una Fecha de Inicio');
      return;
    }
    if (fechaFinal.isEmpty && openNuevaTarea == 1) {
      mostrarSnackBar(context, 'Ingrese un Fecha Final');
      return;
    }

    ProyectoController proyectoController =
        Provider.of<ProyectoController>(context, listen: false);
    TareaController tareaController =
        Provider.of<TareaController>(context, listen: false);

    if (proyectoController.selectedItems["idTarea"] == 0) {
      // Si el elemento seleccionado es un Proyecto o no hay ningún elemento seleccionado
      await proyectoController.updateProyecto(
        ProyectoModel(
          idProyecto: idProyecto,
          nombreProyecto: nomProyecto,
        ),
      );
      mostrarSnackBar(context, 'Proyecto Actualizado', color: Colors.green);
    } else {
      // Si el elemento seleccionado es una Tarea, actualizar la tarea y el nombre del proyecto
      await tareaController.updateTarea(
        TareaModel(
          idTarea: proyectoController.selectedItems["idTarea"],
          idProyecto: idProyecto,
          titulo: tituloTarea,
          fechaInicio: fechaInicio,
          fechaCulminacion: fechaFinal,
          fechaCreacion: _fechaCreacionController.text,
          idPrioridad: prioridad == 'Alta'
              ? 1
              : prioridad == 'Media'
                  ? 2
                  : 3,
        ),
      );

      await proyectoController.updateProyecto(
        ProyectoModel(
          idProyecto: idProyecto,
          nombreProyecto: nomProyecto,
        ),
      );
      mostrarSnackBar(context, 'Proyecto Actualizado', color: Colors.green);
    }

    // Crear tareas adicionales si openNuevaTarea es 1
    if (openNuevaTarea == 1 &&
        proyectoController.selectedItems['idTarea'] == 0) {
      await tareaController.createTarea(
        TareaModel(
          idProyecto: idProyecto,
          titulo: tituloTarea,
          fechaInicio: fechaInicio,
          fechaCulminacion: fechaFinal,
          fechaCreacion: _fechaCreacionController.text,
          idPrioridad: prioridad == 'Alta'
              ? 1
              : prioridad == 'Media'
                  ? 2
                  : 3,
        ),
      );
      mostrarSnackBar(context, 'Tarea Creada', color: Colors.green);
    }
    proyectoController.selectedItems = {"idProyecto": idProyecto, "idTarea": 0};
    setState(() => _limpiarCampos(false));
  }

  @override
  Widget build(BuildContext context) {
    ProyectoController proyectoController =
        Provider.of<ProyectoController>(context);

    bool isNombreProyectoEditable =
        proyectoController.selectedItems["idProyecto"] == 0;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BotoneraTopNuevo(
              onPressNuevo: () async {
                final indexPage =
                    Provider.of<PageRouterController>(context, listen: false);
                indexPage.index = 1;
              },
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
                // enabled: isNombreProyectoEditable,
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
