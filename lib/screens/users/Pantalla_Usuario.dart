import 'dart:io';

import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/services/LogicaUsuarios.dart';
import 'package:enrique_masegosac1/screens/Pantalla_Principal.dart';

class Pantalla_Usuario extends StatefulWidget {
  const Pantalla_Usuario({super.key});

  @override
  State<Pantalla_Usuario> createState() => _Pantalla_UsuarioState();
}

class _Pantalla_UsuarioState extends State<Pantalla_Usuario> {
  int _paginaActual = 0;
  final List<Widget> _paginas = [
    const PaginaCompras(),
    const PaginaPedidos(),
    const PaginaYo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bienvenido ${LogicaUsuarios().getUsuarioActual()?.nombre ?? 'Usuario'}",
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      drawer: _buildDrawer(),
      body: _paginas[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaActual,
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Compras',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Yo'),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 8, 179, 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.person, size: 50, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  LogicaUsuarios().getUsuarioActual()?.nombre ?? 'Usuario',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  LogicaUsuarios().getUsuarioActual()?.email ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: _cerrarSesion,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Salir de la Aplicación'),
            onTap: _salirAplicacion,
          ),
        ],
      ),
    );
  }

  void _cerrarSesion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                LogicaUsuarios().cerrarSesion();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Pantalla_Principal(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );
  }

  void _salirAplicacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Salir de la Aplicación'),
          content: const Text(
            '¿Estás seguro de que quieres salir de la aplicación?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Cerrar la aplicación
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 300), () {
                  exit(0);
                });
              },
              child: const Text('Salir'),
            ),
          ],
        );
      },
    );
  }
}

// Página de Compras
class PaginaCompras extends StatelessWidget {
  const PaginaCompras({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'Página de Compras',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Bienvenido, ${LogicaUsuarios().getUsuarioActual()?.nombre ?? 'Usuario'}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Acción de comprar
            },
            child: const Text('Comenzar a Comprar'),
          ),
        ],
      ),
    );
  }
}

// Página de Pedidos
class PaginaPedidos extends StatelessWidget {
  const PaginaPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.list_alt, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'Mis Pedidos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Aquí podrás ver el historial de tus pedidos',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Ver pedidos
            },
            child: const Text('Ver Pedidos'),
          ),
        ],
      ),
    );
  }
}

// Página de Yo (Perfil)
class PaginaYo extends StatelessWidget {
  const PaginaYo({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = LogicaUsuarios().getUsuarioActual();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'Mi Perfil',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          if (usuario != null) ...[
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Nombre'),
                      subtitle: Text(usuario.nombre),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(usuario.email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Teléfono'),
                      subtitle: Text(usuario.telefono),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Editar perfil
            },
            child: const Text('Editar Perfil'),
          ),
        ],
      ),
    );
  }
}
