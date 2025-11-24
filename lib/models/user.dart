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

  // Datos extra para Pantalla "Yo"
  final String email;
  final String telefono;

  User({
    required this.nombre,
    required this.contrasena,
    this.tratamiento,
    this.edad,
    this.lugarnacimiento,
    this.fotoPath,
    this.fotoBytes,
    this.isAdmin = false,
    this.email = '',
    this.telefono = '',
  });

  String getNombre() => nombre;
  String getContrasena() => contrasena;
  String getTratamiento() => tratamiento ?? '';
  String getEdad() => edad ?? '';
  String getLugarNacimiento() => lugarnacimiento ?? '';
  String getFotoPath() => fotoPath ?? '';
  bool getisAdmin() => isAdmin;
}
