import 'package:flutter_test/flutter_test.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:collection/collection.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  group('ProyectoController Tests', () {
    late ProyectoController proyectoController;

    setUp(() {
      proyectoController = ProyectoController();
    });

    test('Cargar Proyectos', () async {
      await proyectoController.loadProyectos();
      print(proyectoController.proyectos.last.nombreProyecto);

      // Usamos isEmpty para verificar si la lista está vacía
      if (proyectoController.proyectos.isEmpty) {
        expect(proyectoController.proyectos, isEmpty);
      } else {
        // Utilizamos isNotEmpty y isInstanceOf para verificar que la lista no está vacía y contiene instancias de ProyectoModel
        expect(proyectoController.proyectos, isNotEmpty);
        expect(
          proyectoController.proyectos,
          everyElement(isInstanceOf<ProyectoModel>()),
        );
      }
    });

    test('Create, update, and delete proyecto', () async {
      final proyecto = ProyectoModel(nombreProyecto: 'Proyecto de prueba last');

      // Create proyecto
      await proyectoController.createProyecto(proyecto);

      // Verify that the proyecto was created
      expect(proyectoController.proyectos, contains(proyecto));

      // Update proyecto
      final updatedProyecto = ProyectoModel(
        idProyecto: proyectoController.proyectos.last.idProyecto,
        nombreProyecto: 'Proyecto actualizado',
      );
      await proyectoController.updateProyecto(updatedProyecto);

      // Verify that the proyecto was updated
      expect(proyectoController.proyectos, contains(updatedProyecto));
      expect(proyectoController.proyectos, isNot(contains(proyecto)));

      // Delete proyecto
      await proyectoController.deleteProyecto(updatedProyecto.idProyecto!);

      // Verify that the proyecto was deleted
      expect(proyectoController.proyectos, isNot(contains(updatedProyecto)));
    });

    test('Get tareas for proyecto should return a list of TareaModel',
        () async {
      final proyecto = ProyectoModel(nombreProyecto: 'Proyecto con tareas');

      // Create proyecto
      await proyectoController.createProyecto(proyecto);

      // Get tareas for proyecto
      final tareas =
          await proyectoController.getTareasForProyecto(proyecto.idProyecto!);

      // Assuming there are no tasks initially in the database
      expect(tareas, isEmpty);
    });
  });
}
