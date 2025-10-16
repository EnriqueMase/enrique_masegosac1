class User {
  final String nombre;
  final String contrasena;
  final String? tratamiento;
  final String? edad;
  final String? lugarnacimiento;

  User({
    required this.nombre,
    this.contrasena = "",
    this.tratamiento = "",
    this.edad = "",
    this.lugarnacimiento = "",
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
}
