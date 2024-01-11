import 'package:flutter/material.dart';

void mostrarSnackBar(BuildContext context, String mensaje, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      mensaje,
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
    backgroundColor: color ?? Colors.redAccent,
    duration: Duration(seconds: 2),
  ));
}
