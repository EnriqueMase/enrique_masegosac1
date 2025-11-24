import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/models/user.dart';
import 'package:enrique_masegosac1/screens/admin/Admin_Screen.dart';
import 'package:enrique_masegosac1/screens/users/Pantalla_Usuario.dart';

class AuthController {
  final LogicaUsuarios _usuarios = LogicaUsuarios();

  Future<void> iniciarSesion({
    required BuildContext context,
    required String nombre,
    required String contrasena,
  }) async {
    final user = _usuarios.validarCredenciales(nombre, contrasena);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _usuarios.setUsuarioActual(user);

    if (user.isAdmin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Admin_Screen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Pantalla_Usuario()),
      );
    }
  }

  User? obtenerUsuarioPorNombre(String nombre) {
    return _usuarios.obtenerUsuarioPorNombre(nombre);
  }
}
