import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/listarProyectos/table_celda.dart';

class HeaderTable extends StatefulWidget {
  HeaderTable({super.key});

  @override
  State<HeaderTable> createState() => _HeaderTableState();
}

class _HeaderTableState extends State<HeaderTable> {
  Color bkgCeldaHeader = const Color.fromARGB(255, 69, 111, 186);
  Color txtCeldaHeader = Colors.white;
  bool isSelectAll = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(6, 1, 4, 1),
          child: Transform.scale(
            scale: 2.8,
            child: Checkbox(
              value: isSelectAll,
              onChanged: (val) {
                isSelectAll = !isSelectAll;
                Provider.of<ProyectoController>(context, listen: false)
                    .seleccionarTodos(isSelectAll);
                setState(() {});
              },
            ),
          ),
        ),
        TableCelda(
          bkgCelda: bkgCeldaHeader,
          txtCelda: 'Proyecto / Tarea',
          txtColor: txtCeldaHeader,
          widthCelda: 160,
        ),
        TableCelda(
          bkgCelda: bkgCeldaHeader,
          txtCelda: 'Fecha de Inicio',
          txtColor: txtCeldaHeader,
          widthCelda: 100,
        ),
        TableCelda(
          bkgCelda: bkgCeldaHeader,
          txtCelda: 'Prioridad',
          txtColor: txtCeldaHeader,
          widthCelda: 100,
        ),
        TableCelda(
          bkgCelda: bkgCeldaHeader,
          txtCelda: 'Fecha de Culminacion',
          txtColor: txtCeldaHeader,
          widthCelda: 110,
        ),
        TableCelda(
          bkgCelda: bkgCeldaHeader,
          txtCelda: 'Fecha de Creacion',
          txtColor: txtCeldaHeader,
          widthCelda: 100,
        ),
      ],
    );
  }
}
