import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/models/proyecto.model.dart';
import 'package:task_gestor/providerControllers/page_router_controller.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/botonera_top.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/listarProyectos/listar_data.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/txtfield_buscar.dart';
import 'package:task_gestor/ui/widgets/snack_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchTxtController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void mostrarDialogoEliminar(String text, VoidCallback funDelete) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmar'),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: funDelete,
                child: const Text('Eliminar'),
              ),
            ],
          );
        },
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<ProyectoController>(
          builder: (context, proyectoController, child) {
            return Column(
              children: [
                BotoneraTop(
                  onPressNuevo: () {
                    final indexPage = Provider.of<PageRouterController>(context,
                        listen: false);
                    indexPage.index = 1;
                  },
                  onPressEditar: () {
                    final indexPage = Provider.of<PageRouterController>(context,
                        listen: false);
                    indexPage.index =
                        proyectoController.selectedItems['idProyecto'] != 0
                            ? 2
                            : proyectoController.selectedItems['idTarea'] != 0
                                ? 2
                                : 0;
                  },
                  onPressEliminar: () async {
                    String message =
                        proyectoController.selectedItems['idProyecto'] != 0
                            ? '¿Desea Eliminar el Proyecto(s)?'
                            : proyectoController.selectedItems['idTarea'] != 0
                                ? '¿Desea Eliminar la tarea(s)?'
                                : '¿Desea Eliminar estos elementos?';
                    mostrarDialogoEliminar(
                      message,
                      () async {
                        await proyectoController.deleteItemsSelected();
                        await proyectoController.loadProyectos();
                        Navigator.of(context).pop();
                        final indexPage = Provider.of<PageRouterController>(
                            context,
                            listen: false);
                        indexPage.index = 3;
                      },
                    );
                  },
                  onPressCompartir: () {},
                  onPressCerrarSesion: () {},
                ),
                TxtFieldBuscar(searchController: _searchTxtController),
                const ListarProyectos(),
              ],
            );
          },
        ),
      ),
    );
  }
}
