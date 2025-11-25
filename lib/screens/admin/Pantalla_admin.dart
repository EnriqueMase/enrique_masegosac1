import 'package:enrique_masegosac1/screens/admin/GestionPedidos.dart';
import 'package:enrique_masegosac1/screens/admin/GestionProductos.dart';
import 'package:enrique_masegosac1/screens/admin/GestionUsuarios.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/widgets/drawer.dart';

class PantallaAdmin extends StatelessWidget {
  const PantallaAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final user = LogicaUsuarios().getUsuarioActual();

    return Scaffold(
      drawer: const Cdrawer(),
      appBar: AppBar(
        title: Text('Administrador ${user != null ? user.nombre : ''}'),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Panel de administración',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GestionUsuariosPage(),
                  ),
                );
              },
              icon: const Icon(Icons.group),
              label: const Text('Gestión de usuarios'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GestionProductosPage(),
                  ),
                );
              },
              icon: const Icon(Icons.inventory),
              label: const Text('Gestión de productos'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GestionPedidosPage()),
                );
              },
              icon: const Icon(Icons.receipt_long),
              label: const Text('Gestión de pedidos'),
            ),
          ],
        ),
      ),
    );
  }
}
