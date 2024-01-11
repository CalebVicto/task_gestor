import 'package:flutter/material.dart';

class TxtFieldBuscar extends StatelessWidget {
  const TxtFieldBuscar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          const Text(
            'Buscar:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () => _searchController.clear(),
                  child: const Icon(
                    size: 20,
                    Icons.clear,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
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
        ],
      ),
    );
  }
}
