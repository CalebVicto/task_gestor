import 'package:flutter/material.dart';

class NuevaTarea extends StatefulWidget {
  final TextEditingController nomTareaController;
  final TextEditingController fechaCreacionController;
  final TextEditingController fechaInicioController;
  final TextEditingController fechaFinalController;
  final TextEditingController dropdownValueController;

  const NuevaTarea({
    Key? key,
    required this.nomTareaController,
    required this.fechaCreacionController,
    required this.fechaInicioController,
    required this.fechaFinalController,
    required this.dropdownValueController,
  }) : super(key: key);

  @override
  State<NuevaTarea> createState() => _NuevaTareaState();
}

class _NuevaTareaState extends State<NuevaTarea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ? ---- NOM DE LA TAREA
        NombreTarea(controller: widget.nomTareaController),

        // ? --- FECHA DE CREACION
        fechaCreacion(controller: widget.fechaCreacionController),

        // ? --- FECHA DE INICIO
        fechaInicio(controller: widget.fechaInicioController),

        // ? --- FECHA DE FINAL
        fechaFinal(controller: widget.fechaFinalController),

        prioridadOption(dropdownValue: widget.dropdownValueController)
      ],
    );
  }

  Future<void> _selectDate(TextEditingController ctrTxt) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(21000),
    );

    if (_picked != null) {
      setState(() {
        ctrTxt.text =
            _picked.toString().split(" ")[0].split('-').reversed.join('/');
      });
    }
  }

  Container prioridadOption({required TextEditingController dropdownValue}) {
    const List<String> list = ['Alta', 'Media', 'Baja'];
    dropdownValue.text =
        list.first; // Puedes establecer un valor predeterminado aquí

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            child: Text(
              'Prioridad:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            child: Expanded(
              child: DropdownButtonFormField<String>(
                value: dropdownValue.text,
                items: list.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null && list.contains(val)) {
                    dropdownValue.text = val;
                    setState(() {});
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 237, 237, 237),
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 166, 166, 166),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container fechaCreacion({required TextEditingController controller}) {
    controller.text =
        DateTime.now().toString().split(' ')[0].split('-').reversed.join('/');
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Fecha de Creacion:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            child: Expanded(
              child: TextField(
                enabled: false,
                controller: controller,
                onTap: () {
                  _selectDate(controller);
                },
                readOnly: true,
                keyboardType: TextInputType.datetime,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 237, 237, 237),
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 166, 166, 166),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container fechaInicio({required TextEditingController controller}) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Fecha de Inicio:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            child: Expanded(
              child: TextField(
                controller: controller,
                onTap: () {
                  _selectDate(controller);
                },
                readOnly: true,
                keyboardType: TextInputType.datetime,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 237, 237, 237),
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 166, 166, 166),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container fechaFinal({required TextEditingController controller}) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Fecha Final:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            child: Expanded(
              child: TextField(
                controller: controller,
                onTap: () {
                  _selectDate(controller);
                },
                readOnly: true,
                keyboardType: TextInputType.datetime,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 237, 237, 237),
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 166, 166, 166),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding NombreTarea({required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color.fromARGB(255, 237, 237, 237),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 166, 166, 166),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
