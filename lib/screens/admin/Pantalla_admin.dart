import 'package:enrique_masegosac1/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final user = LogicaUsuarios().getUsuarioActual();

    return Scaffold(
      drawer: const Cdrawer(),
      appBar: AppBar(
        title: Text(l10n.adminWelcome(user?.nombre ?? '')),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.adminPanel,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              label: Text(l10n.userManagement),
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
              label: Text(l10n.productManagement),
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
              label: Text(l10n.orderManagement),
            ),
          ],
        ),
      ),
    );
  }
}
