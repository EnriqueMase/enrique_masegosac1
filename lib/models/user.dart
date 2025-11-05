import 'dart:typed_data';

class User {
  final String nombre;
  final String contrasena;
  final String? tratamiento;
  final String? edad;
  final String? lugarnacimiento;
  final String? fotoPath;
  final Uint8List? fotoBytes;

  User({
    required this.nombre,
    this.contrasena = "",
    this.tratamiento = "",
    this.edad = "",
    this.lugarnacimiento = "",
    this.fotoPath = "",
    this.fotoBytes,
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
}
