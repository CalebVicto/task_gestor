import 'package:flutter/material.dart';

class BtnClose extends StatelessWidget {
  final VoidCallback onPressed;

  const BtnClose({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Ink(
        decoration: ShapeDecoration(
          color: const Color.fromARGB(255, 235, 4, 29),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: IconButton(
          tooltip: 'Cerrar Sesión',
          onPressed: onPressed,
          icon: const Icon(
            size: 25,
            Icons.close_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
