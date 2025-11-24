import 'package:flutter/material.dart';

Widget productoCard({
  required String nombre,
  required double precio,
  required int stock,
  required String descripcion,
  required int cantidad,
  required VoidCallback onAdd,
  required VoidCallback onRemove,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 3,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // === IMAGEN VACÍA PARA QUE LUEGO LA PONGAS ===
          Image.asset(
            'assets/images/product_placeholder.png',
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 12),

          // === INFORMACIÓN DEL PRODUCTO ===
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Precio: $precio€'),
                Text('Stock: $stock'),
                Text(
                  descripcion,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),

          // === CONTROLES DE CANTIDAD ===
          Row(
            children: [
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.remove, color: Colors.red),
              ),
              Text(
                cantidad.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: onAdd,
                icon: const Icon(Icons.add, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
