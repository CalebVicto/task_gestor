import 'package:flutter/material.dart';

class BtnTxt extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const BtnTxt({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 0, right: 0),
      ),
      child: Column(
        children: [
          Icon(icon, size: 70),
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
