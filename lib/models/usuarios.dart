import 'dart:typed_data';

class Usuarios {
  final String nombre;
  final String contrasena;
  final String? tratamiento;
  final String? edad;
  final String? lugarnacimiento;

  final String? fotoPath;
  final Uint8List? fotoBytes;
  // decir si es admin o no
  final bool isAdmin;
  // bloquear el usuarios
  bool isBlocked;

  // Datos extra para la pantalla de usuario
  final String email;
  final String telefono;

  Usuarios({
    required this.nombre,
    required this.contrasena,
    this.tratamiento,
    this.edad,
    this.lugarnacimiento,
    this.fotoPath,
    this.fotoBytes,
    this.isAdmin = false,
    this.isBlocked = false,
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
