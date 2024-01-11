import 'package:flutter/material.dart';
import 'package:task_gestor/ui/pages/homePage/widgets/btn_close.dart';
import 'package:task_gestor/ui/widgets/btn_txt_icon.dart';

class BotoneraTop extends StatelessWidget {
  final VoidCallback onPressNuevo;
  final VoidCallback onPressEditar;
  final VoidCallback onPressEliminar;
  final VoidCallback onPressCompartir;
  final VoidCallback onPressCerrarSesion;

  const BotoneraTop({
    super.key,
    required this.onPressNuevo,
    required this.onPressEditar,
    required this.onPressEliminar,
    required this.onPressCompartir,
    required this.onPressCerrarSesion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BtnTxt(
                onPressed: onPressNuevo,
                icon: Icons.note_add_outlined,
                label: 'Nuevo',
              ),
              SizedBox(width: 5),
              BtnTxt(
                onPressed: onPressEditar,
                icon: Icons.edit_document,
                label: 'Editar',
              ),
              SizedBox(width: 5),
              BtnTxt(
                onPressed: onPressEliminar,
                icon: Icons.delete_forever_outlined,
                label: 'Eliminar',
              ),
              SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: BtnTxt(
                  onPressed: onPressCompartir,
                  icon: Icons.share,
                  label: 'Compartir',
                ),
              ),
            ],
          ),
          BtnClose(onPressed: onPressCerrarSesion),
        ],
      ),
    );
  }
}
