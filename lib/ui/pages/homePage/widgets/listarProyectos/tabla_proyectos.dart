// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/listarProyectos/table_header.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/listarProyectos/table_row.dart';

class TablaProyectos extends StatefulWidget {
  final List<ProyectoModel>? proyectos;

  const TablaProyectos({super.key, required this.proyectos});

  @override
  State<TablaProyectos> createState() => _TablaProyectosState();
}

class _TablaProyectosState extends State<TablaProyectos> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          const SizedBox(height: 10),
          HeaderTable(),
          ...(widget.proyectos?.map((e) => RowTable(proyecto: e)) ?? []),
        ],
      ),
    );
  }
}
