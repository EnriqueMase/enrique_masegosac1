import 'package:enrique_masegosac1/screens/users/Pagina_Compras.dart';
import 'package:enrique_masegosac1/screens/users/Pagina_Contacto.dart';
import 'package:enrique_masegosac1/screens/users/Pagina_Pedidos.dart';
import 'package:enrique_masegosac1/screens/users/Pagina_Yo.dart';
import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';

class Pantalla_Usuario extends StatefulWidget {
  const Pantalla_Usuario({super.key});

  @override
  State<Pantalla_Usuario> createState() => _Pantalla_UsuarioState();
}

class _Pantalla_UsuarioState extends State<Pantalla_Usuario> {
  int _paginaActual = 0;

  final List<Widget> _paginas = const [
    PaginaCompras(),
    PaginaPedidos(),
    PaginaYo(),
    PaginaContacto(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const Cdrawer(),
      // Páginas principales; se mantiene en memoria para preservar estado.
      body: _paginas[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaActual,
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        selectedItemColor: const Color.fromARGB(255, 8, 179, 2),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        // barra de abajo
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: l10n.store,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt_long),
            label: l10n.orders,
          ),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: l10n.me),
          BottomNavigationBarItem(
            icon: const Icon(Icons.contact_mail),
            label: l10n.contact,
          ),
        ],
      ),
    );
  }
}
