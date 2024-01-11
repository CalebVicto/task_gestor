// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/ui/widgets/proyecto_card.dart';

class ProyectoList extends StatefulWidget {
  @override
  State<ProyectoList> createState() => _ProyectoListState();
}

class _ProyectoListState extends State<ProyectoList> {
  late Future<List<ProyectoModel>> _proyectosFuture;

  @override
  void initState() {
    super.initState();
    _proyectosFuture =
        Provider.of<ProyectoController>(context, listen: false).loadProyectos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Proyectos'),
      ),
      body: FutureBuilder(
        future: _proyectosFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty)
              return const Center(child: Text('No hay datos'));
            return const Text('Hay Datos');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
