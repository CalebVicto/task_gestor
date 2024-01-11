import 'package:flutter/material.dart';
import 'package:task_gestor/models/proyecto.model.dart';

class ProyectoCard extends StatelessWidget {
  final ProyectoModel proyecto;

  ProyectoCard({required this.proyecto});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(proyecto.nombreProyecto),
        onTap: () {
          // Implementa la navegación o la lógica que necesites al hacer clic en un proyecto
        },
      ),
    );
  }
}
