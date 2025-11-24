import 'dart:io';

import 'package:enrique_masegosac1/screens/auth/Login_screen.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PaginaYo extends StatelessWidget {
  const PaginaYo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = LogicaUsuarios().getUsuarioActual();

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Login_screen()),
        );
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: const Text('Mi perfil'),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  user.fotoPath != null && user.fotoPath!.isNotEmpty
                  ? FileImage(File(user.fotoPath!))
                  : null,
              child: (user.fotoPath == null || user.fotoPath!.isEmpty)
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              user.nombre,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Email: ${user.email}'),
            Text('Teléfono: ${user.telefono}'),
            const SizedBox(height: 8),
            Text('Edad: ${user.getEdad()}'),
            Text('Lugar de nacimiento: ${user.getLugarNacimiento()}'),
          ],
        ),
      ),
    );
  }
}
