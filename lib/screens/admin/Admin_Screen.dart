import 'dart:io';

import 'package:enrique_masegosac1/screens/auth/Login_screen.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/config/utils/Camera.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:enrique_masegosac1/models/user.dart';

class Admin_Screen extends StatefulWidget {
  const Admin_Screen({super.key});

  @override
  State<Admin_Screen> createState() => _Admin_ScreenState();
}

class _Admin_ScreenState extends State<Admin_Screen> {
  String? _photoPath;

  @override
  Widget build(BuildContext context) {
    final User? usuario = LogicaUsuarios().getUsuarioActual();

    // Si no hay usuario, volvemos al login
    if (usuario == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login_screen()),
        );
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final String nombreUsuario = usuario.getNombre();

    return Scaffold(
      drawer: const Cdrawer(),
      appBar: AppBar(
        title: const Text('Panel de administrador'),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Bienvenido $nombreUsuario',
              style: const TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 12, 99, 8),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'Aquí puedes ver información adicional.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            SizedBox(
              height: 350,
              child: _photoPath != null
                  ? Image(image: FileImage(File(_photoPath!)), fit: BoxFit.fill)
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'select_photo',
            child: const Icon(Icons.image),
            onPressed: () async {
              final path = await Camera().selectPhoto();
              if (path == null) return;
              setState(() {
                _photoPath = path;
              });
            },
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'take_photo',
            child: const Icon(Icons.camera_alt),
            onPressed: () async {
              final path = await Camera().takePhoto();
              if (path == null) return;
              setState(() {
                _photoPath = path;
              });
            },
          ),
        ],
      ),
    );
  }
}
