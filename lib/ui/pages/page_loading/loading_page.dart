import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/providerControllers/page_router_controller.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, this.indice = 0}) : super(key: key);

  final int indice;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    // Agrega un retraso de 2 segundos antes de redirigir
    Future.delayed(const Duration(seconds: 1), () {
      final indexPage =
          Provider.of<PageRouterController>(context, listen: false);
      indexPage.index = widget.indice;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
