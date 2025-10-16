import 'package:enrique_masegosac1/screens/PantallaPerfil.dart';
import 'package:enrique_masegosac1/services/LogicaUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/screens/Ajustes.dart';
import 'package:enrique_masegosac1/screens/Pantalla_Principal.dart';
import 'package:flutter/services.dart';

class Cdrawer extends StatefulWidget {
  const Cdrawer({super.key});

  @override
  State<Cdrawer> createState() => _CdrawerState();
}

class _CdrawerState extends State<Cdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 10, 255, 2)),
            child: Text('Menu'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Pantalla Principal'),
            onTap: () {
              Navigator.pop(context);

              LogicaUsuarios().cerrarSesion();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Pantalla_Principal()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mi perfil'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PantallaPerfil()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Ajustes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ajustes()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Salir de la aplicación'),
            onTap: () {
              // Mostrar diálogo de confirmación
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Salir de la aplicación"),
                    content: Text("¿Estás seguro de que quieres salir?"),
                    actions: [
                      TextButton(
                        child: Text("Cancelar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Salir"),
                        onPressed: () {
                          // Cerrar la aplicación
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
