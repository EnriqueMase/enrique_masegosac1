import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/models/usuarios.dart';
import 'package:enrique_masegosac1/screens/admin/Pantalla_admin.dart';
import 'package:enrique_masegosac1/screens/users/Pantalla_Usuario.dart';

class ControladorAutenticacion {
  final LogicaUsuarios _usuarios = LogicaUsuarios();

  /// Valida credenciales locales y redirige según rol admin/usuario.
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
        MaterialPageRoute(builder: (_) => const PantallaAdmin()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Pantalla_Usuario()),
      );
    }
  }

  Usuarios? obtenerUsuarioPorNombre(String nombre) {
    return _usuarios.obtenerUsuarioPorNombre(nombre);
  }
}
