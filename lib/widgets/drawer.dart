import 'package:enrique_masegosac1/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: const Color.fromARGB(255, 8, 179, 2)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.menu,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),

            // Selector de idioma
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, state) =>
                    buildLanguageSwitch(context, Theme.of(context), state),
              ),
            ),

            const Divider(),

            // Ajustes
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(l10n.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Ajustes()),
                );
              },
            ),

            // Cerrar sesión
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(l10n.logout),
              onTap: () {
                LogicaUsuarios().cerrarSesion();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const PantallaLogin()),
                  (route) => false,
                );
              },
            ),

            // Salir de la aplicación
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(l10n.exitApp),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(l10n.exitAppTitle),
                    content: Text(l10n.exitAppConfirm),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(l10n.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Text(l10n.exit),
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
