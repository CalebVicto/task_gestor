import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_gestor/providerControllers/page_router_controller.dart';
import 'package:task_gestor/ui/widgets/btn_txt_icon.dart';

class BotoneraTopNuevo extends StatelessWidget {
  final VoidCallback onPressNuevo;
  final VoidCallback onPressGrabar;

  const BotoneraTopNuevo({
    super.key,
    required this.onPressNuevo,
    required this.onPressGrabar,
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
                onPressed: onPressGrabar,
                icon: Icons.save_outlined,
                label: 'Grabar',
              ),
            ],
          ),
          Container(
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
                onPressed: () {
                  final indexPage =
                      Provider.of<PageRouterController>(context, listen: false);
                  indexPage.index = 0;
                },
                icon: const Icon(
                  size: 25,
                  Icons.close_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
