import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/providerControllers/page_router_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    final indexPage = Provider.of<PageRouterController>(context);

    return AppBar(
      title: Center(
        child: Text(
          indexPage.index == 2
              ? 'Modificar un proyecto/tarea'
              : indexPage.index == 1
                  ? 'Crear un Proyecto/tarea'
                  : 'Tareas Registradas',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 20, 40, 160),
    );
  }
}
