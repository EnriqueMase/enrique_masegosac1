import 'dart:typed_data';

class User {
  final String nombre;
  final String contrasena;
  final String? tratamiento;
  final String? edad;
  final String? lugarnacimiento;
  final String? fotoPath;
  final Uint8List? fotoBytes;
  final bool isAdmin;
  // parte de la pantalla user
  final String email;
  final String telefono;

  User({
    required this.nombre,
    this.contrasena = "",
    this.tratamiento = "",
    this.edad = "",
    this.lugarnacimiento = "",
    this.fotoPath = "",
    this.fotoBytes,
    this.isAdmin = false,
    // parte de la pantalla user
    this.email = "",
    this.telefono = "",
  });

  String getNombre() {
    return nombre;
  }

  String getContrasena() {
    return contrasena;
  }

  String getTratamiento() {
    return tratamiento ?? "";
  }

  String getEdad() {
    return edad ?? "";
  }

  String getLugarNacimiento() {
    return lugarnacimiento ?? "";
  }

  String getFotoPath() {
    return fotoPath ?? "";
  }

  bool getisAdmin() {
    return isAdmin;
  }
}
