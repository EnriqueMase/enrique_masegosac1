import 'package:enrique_masegosac1/locale_bloc/locale_bloc.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_state.dart';
import 'package:enrique_masegosac1/screens/auth/Pantalla_login.dart';
import 'package:enrique_masegosac1/screens/users/Pagina_Yo.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/widgets/cambio_lenguajes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:enrique_masegosac1/screens/Ajustes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cdrawer extends StatelessWidget {
  const Cdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 8, 179, 2)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menú',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),

            // 🔄 Selector de idioma
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, state) =>
                    buildLanguageSwitch(context, Theme.of(context), state),
              ),
            ),

            const Divider(),

            // 👤 Mi perfil
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mi perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaginaYo()),
                );
              },
            ),

            // ⚙ Ajustes
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Ajustes()),
                );
              },
            ),

            // 🚪 Cerrar sesión
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                LogicaUsuarios().cerrarSesion();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const PantallaLogin()),
                  (route) => false,
                );
              },
            ),

            // ❌ Salir de la aplicación
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Salir de la aplicación'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Salir de la aplicación'),
                    content: const Text('¿Estás seguro de que quieres salir?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: const Text('Salir'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
