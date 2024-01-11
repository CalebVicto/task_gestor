import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/providerControllers/page_router_controller.dart';
import 'package:task_gestor/providerControllers/proyecto_controller.dart';
import 'package:task_gestor/providerControllers/tarea_controller.dart';
import 'package:task_gestor/ui/pages/crear_proyecto/nuevo_proyecto.page.dart';
import 'package:task_gestor/ui/pages/editar_proyecto/editar_proyecto.page.dart';
import 'package:task_gestor/ui/pages/homePage/home_page.dart';
import 'package:task_gestor/ui/pages/page_loading/loading_page.dart';
import 'package:task_gestor/ui/widgets/app_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProyectoController()),
        ChangeNotifierProvider(create: (context) => TareaController()),
        ChangeNotifierProvider(create: (context) => PageRouterController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final List<Widget> _pages = const [
    HomePage(),
    NuevoProyectoPage(),
    EditarProyectoPage(),
    LoadingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 237, 237, 237),
        appBar: const CustomAppBar(),
        body: Consumer<PageRouterController>(
          builder: (context, pageRouter, child) {
            return _pages[pageRouter.index];
          },
        ),
      ),
    );
  }
}
