import 'package:flutter/material.dart';

class TableCelda extends StatelessWidget {
  TableCelda({
    super.key,
    required this.bkgCelda,
    required this.txtCelda,
    required this.txtColor,
    this.widthCelda = 150,
  });

  EdgeInsets paddingCelda = const EdgeInsets.fromLTRB(10, 0, 10, 0);
  EdgeInsets marginCelda = const EdgeInsets.all(1);
  double widthCelda;
  final Color bkgCelda;
  final String txtCelda;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: widthCelda,
      color: bkgCelda,
      padding: paddingCelda,
      margin: marginCelda,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          txtCelda,
          style: TextStyle(
            color: txtColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
