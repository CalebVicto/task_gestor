// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/listarProyectos/tabla_proyectos.dart';

class ListarProyectos extends StatefulWidget {
  const ListarProyectos({super.key});

  @override
  State<ListarProyectos> createState() => _ListarProyectosState();
}

class _ListarProyectosState extends State<ListarProyectos> {
  late Future<List<ProyectoModel>> _proyectos;

  @override
  void initState() {
    super.initState();
    _proyectos =
        Provider.of<ProyectoController>(context, listen: false).loadProyectos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _proyectos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TablaProyectos(proyectos: snapshot.data);
        } else if (snapshot.hasError) {
          return const Text('Error');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
